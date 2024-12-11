import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneyapp/database/Database.dart';

class EditExpenseLogic extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;
  int id = 0;
  int value = 0;
  String type = 'food'; // khởi tạo giá trị food
  String note = '';
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
    textcontroller.text = formatNumber(value.toString());
    // khởi tạo giá trị ban đầu
  }

  // Hàm format số
  String formatNumber(String s) {
    final number = double.tryParse(s.replaceAll(',', ''));
    if (number == null) {
      return s; // Trả về chuỗi gốc nếu không thể chuyển đổi
    }
    final formatter =
        NumberFormat('#,##0'); // Định dạng có dấu phẩy mỗi hàng nghìn
    return formatter.format(number);
  }

// format lại khi thay đổi
  void onChanged(String value) {
    int? parsedValue = int.tryParse(value.replaceAll(',', ''));

    if (parsedValue != null) {
      this.value = parsedValue;

      // Cập nhật lại giá trị của TextField với định dạng đã format
      String formattedValue = formatNumber(value);
      textcontroller.text = formattedValue;

      // Đặt con trỏ vào cuối sau khi cập nhật text
      textcontroller.selection = TextSelection.fromPosition(
          TextPosition(offset: textcontroller.text.length));
      update();
    }
  }
}
