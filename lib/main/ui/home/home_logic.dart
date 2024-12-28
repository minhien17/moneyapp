import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/transaction_model.dart';

class HomeLogic extends GetxController with SingleGetTickerProviderMixin {
  DatabaseService databaseService = DatabaseService.instance;
  int totalExpense = 0;
  var lists = <Transaction>[];
  TabController? tabController;

  bool isVisible = true;

  @override
  void onInit() {
    // TODO: implement onInit
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
    getTotalExpense();
  }

  void getTotalExpense() async {
    totalExpense = await databaseService.getBalance();
    update();
  }

  void changeVisible() {
    isVisible = !isVisible;
    update();
  }
}
