import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/transaction_model.dart';

class TransactionLogic extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;
  var lists = <Transaction>[];
  int income = 0;
  int totalExpense = 0;
  List<String> months = [];

  @override
  void onInit() {
    // TODO: implement onInit
    getListExpense();
    getTotalExpense();
    getIncome();
    // Tạo mảng tháng từ năm 2024 đến 2026
    for (int year = 2024; year <= 2024; year++) {
      for (int month = 1; month <= 12; month++) {
        months.add('$month/$year'); // Định dạng MM/YYYY
      }
    }
    super.onInit();
  }

  getListExpense() async {
    var list = await databaseService.getListExpense();
    lists = list!;
    print(lists);
    update();
  }

  void deleteExpense(int id) async {
    databaseService.deleteExpense(id);
    getListExpense();
  }

  void resetData() {
    getTotalExpense();
    getIncome();
    getListExpense(); // Gọi lại phương thức để làm mới dữ liệu
  }

  void getIncome() async {
    income = await databaseService.getTotalIncome();
    update();
  }

  void getTotalExpense() async {
    totalExpense = await databaseService.getTotalExpense();
    print(totalExpense);
    update();
  }
}
