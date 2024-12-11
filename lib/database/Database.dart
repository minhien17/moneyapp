import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:moneyapp/main/model/Expense.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  final String _expenseTableName = "expense";
  final String _idColumnName = "id";
  final String _valueColumnName = "value";
  final String _noteColumnName = "note";
  final String _typeColumnName = "type";

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
          CREATE TABLE $_expenseTableName (
            $_idColumnName INTEGER PRIMARY KEY,
            $_valueColumnName INTEGER NOT NULL,
            $_typeColumnName TEXT NOT NULL,
            $_noteColumnName TEXT
          )
      ''');
      print('table create');
    });
    // await deleteDatabase(databasePath);
    return database;
  }

  Future<List<Expense>?> getExpense() async {
    final db = await database;
    final data = await db.query(_expenseTableName);
    // data la du lieu trong data

    List<Expense> trans = data
        .map((e) => Expense(
            id: e["id"] as int,
            value: e["value"] as int,
            type: e["type"] as String,
            note: e["note"] as String))
        .toList();
    // ep du lieu cua data vao Expense
    // print(trans);
    return trans;
  }

  void addExpense(
    int value,
    String type,
    String note,
  ) async {
    final db = await database;
    await db.insert(_expenseTableName, {
      _valueColumnName: value,
      _typeColumnName: type,
      _noteColumnName: note,
    });
    print("add $value");
  }

  void deleteExpense(
    int id,
  ) async {
    final db = await database;
    await db.delete(_expenseTableName, where: 'id = ?', whereArgs: [
      id,
    ]);
    print('delete ok');
  }

  void updateExpense(int id, int value, String type, String note) async {
    final db = await database;
    await db.update(
        _expenseTableName,
        {
          _valueColumnName: value,
          _typeColumnName: type,
          _noteColumnName: note,
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
        'SELECT SUM($_valueColumnName) AS total FROM $_expenseTableName');

    // Kiểm tra kết quả truy vấn và trả về tổng dưới dạng int
    if (result.isNotEmpty && result[0]['total'] != null) {
      return int.parse(result[0]['total'].toString()); // Chuyển đổi thành int
    } else {
      return 0; // Nếu không có kết quả hoặc tổng bằng null, trả về 0
    }
  }
}
