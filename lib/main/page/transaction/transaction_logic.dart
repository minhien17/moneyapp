import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Expense.dart';

class TransactionLogic extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;
  var lists = <Expense>[];

  @override
  void onInit() {
    // TODO: implement onInit
    getListExpense();
    super.onInit();
  }

  getListExpense() async {
    var list = await databaseService.getExpense();
    lists = list!;
    update();
  }

  void deleteExpense(int id) async {
    databaseService.deleteExpense(id);
    getListExpense();
  }

  void resetData() {
    getListExpense(); // Gọi lại phương thức để làm mới dữ liệu
    update();
  }
}
