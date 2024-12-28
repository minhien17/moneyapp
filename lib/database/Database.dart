import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;
import 'package:moneyapp/main/model/transaction_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  final String _transactionTableName =
      "transactions"; // transaction không s là bảng có sẵn trong sqlite
  final String _idColumnName = "id";
  final String _valueColumnName = "value";
  final String _noteColumnName = "note";
  final String _typeColumnName = "type";
  final String _typeInOutColumnName = "inout";
  final String _dateColumnName = "date";
  final String _balanceColumnName = "balance";

  //setup db
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    final database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $_transactionTableName (
            $_idColumnName INTEGER PRIMARY KEY,
            $_valueColumnName INTEGER NOT NULL,
            $_typeColumnName TEXT NOT NULL,
            $_noteColumnName TEXT,
            $_dateColumnName TEXT NOT NULL,
            $_typeInOutColumnName INTEGER NOT NULL,
            $_balanceColumnName INTEGER NOT NULL
          )
      ''');
      // in out type - 1 là out - expense, 2 là in
      // date - Text chuyển từ ngày sang isostring
      print('table create');
    });
    // await deleteDatabase(databasePath);
    return database;
  }

  Future<List<Transaction>?> getListExpense() async {
    final db = await database;
    final data = await db.query(_transactionTableName);
    // data la du lieu trong data

    List<Transaction> trans = data
        .map((e) => Transaction(
            id: e["id"] as int,
            value: e["value"] as int,
            type: e["type"] as String,
            note: e["note"] as String,
            date: e["date"] as String,
            typeInOut: e["inout"] as int,
            balance: e["balance"] as int))
        .toList();
    // ep du lieu cua data vao Expense
    // print(trans);
    return trans;
  }

  Future<void> addExpense(
    int value,
    String type,
    String note,
    String date,
  ) async {
    final db = await database;

    int currentBalance = await getBalance();

    // Tính toán số dư mới (balance)
    int newBalance = currentBalance - value; // mặc định là expense 1

    await db.insert(_transactionTableName, {
      _valueColumnName: value,
      _typeColumnName: type,
      _noteColumnName: note,
      _typeInOutColumnName: 1,
      _dateColumnName: date,
      _balanceColumnName: newBalance
    });
    print("add $value, balance $newBalance");
  }

  void deleteExpense(
    int id,
  ) async {
    final db = await database;
    await db.delete(_transactionTableName, where: 'id = ?', whereArgs: [
      id,
    ]);
    print('delete ok');
  }

  Future<void> updateExpense(int id, int value, String type, String note,
      int typeInOut, String date) async {
    final db = await database;
    await db.update(
        _transactionTableName,
        {
          _valueColumnName: value,
          _typeColumnName: type,
          _noteColumnName: note,
          _typeInOutColumnName: typeInOut,
          _dateColumnName: date
        },
        where: 'id=?',
        whereArgs: [
          id,
        ]);
  }

  getTotalExpense() async {
    // tổng chi tiêu
    final db = await database;

    var result = await db.rawQuery(
        'SELECT SUM($_valueColumnName) AS total FROM $_transactionTableName WHERE $_typeInOutColumnName = 1');

    // Kiểm tra kết quả truy vấn và trả về tổng dưới dạng int
    if (result.isNotEmpty && result[0]['total'] != null) {
      return int.parse(result[0]['total'].toString()); // Chuyển đổi thành int
    } else {
      return 0; // Nếu không có kết quả hoặc tổng bằng null, trả về 0
    }
  }

  getTotalIncome() async {
    final db = await database;

    var result = await db.rawQuery(
        'SELECT SUM($_valueColumnName) AS total FROM $_transactionTableName WHERE $_typeInOutColumnName = 2');

    // Kiểm tra kết quả truy vấn và trả về tổng dưới dạng int
    if (result.isNotEmpty && result[0]['total'] != null) {
      return int.parse(result[0]['total'].toString()); // Chuyển đổi thành int
    } else {
      return 0; // Nếu không có kết quả hoặc tổng bằng null, trả về 0
    }
  }

  Future<int> getBalance() async {
    final db = await database;
    // Lấy giao dịch cuối cùng để lấy balance hiện tại
    List<Map<String, dynamic>> result = await db.query(
      _transactionTableName,
      orderBy: '$_dateColumnName DESC',
      limit: 1,
    );

    int currentBalance = 0;
    if (result.isNotEmpty) {
      currentBalance = result.first[_balanceColumnName]; // Lấy balance hiện tại
    }
    return currentBalance;
  }
}
