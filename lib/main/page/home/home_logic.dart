import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Expense.dart';

class HomeLogic extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;
  int totalExpense = 10;
  var lists = <Expense>[];

  bool isVisible = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTotalExpense();
  }

  void getTotalExpense() async {
    totalExpense = await databaseService.getTotalExpense();
    update();
  }

  void changeVisible() {
    isVisible = !isVisible;
    update();
  }
}
