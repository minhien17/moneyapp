import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/utils/common.dart';

class EditExpenseLogic extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;
  int id = 0;
  int value = 0;
  String type = 'food'; // khởi tạo giá trị food
  String note = '';
  DateTime date = DateTime.now();
  // Kiểm soát dữ liệu nhập số
  TextEditingController textcontroller = TextEditingController();

  var args = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    id = args['id'];
    type = args['type'];
    value = args['value'];
    note = args['note'];
    date = DateTime.parse(args['date']);
    textcontroller.text = Common.formatNumber(value.toString());
    // khởi tạo giá trị ban đầu
  }

// format lại khi thay đổi
  void onChanged(String value) {
    int? parsedValue = int.tryParse(value.replaceAll(',', ''));

    if (parsedValue != null) {
      this.value = parsedValue;

      // Cập nhật lại giá trị của TextField với định dạng đã format
      String formattedValue = Common.formatNumber(value);
      textcontroller.text = formattedValue;

      // Đặt con trỏ vào cuối sau khi cập nhật text
      textcontroller.selection = TextSelection.fromPosition(
          TextPosition(offset: textcontroller.text.length));
      update();
    }
  }

  Future<void> updateExpense(int id, int value, String type, String note,
      int typeInOut, DateTime date) async {
    String dateStr = date.toIso8601String();
    await databaseService.updateExpense(
        id, value, type, note, typeInOut, dateStr);
  }
}
