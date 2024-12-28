import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Icon.dart';
import 'package:moneyapp/main/model/ListIcon.dart';
import 'package:moneyapp/main/ui/edit_expense/edit_expense_logic.dart';
import 'package:moneyapp/main/ui/transaction/transaction_logic.dart';
import 'package:moneyapp/main/utils/common.dart';
import 'package:moneyapp/res/app_colors.dart';
import 'package:moneyapp/res/app_styles.dart';

class EditExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditExpenseLogic>(
        init: EditExpenseLogic(),
        builder: (controller) {
          void datePicker() async {
            DateTime? picked = await showDatePicker(
                context: context,
                initialDate: controller.date,
                firstDate: DateTime(2024),
                lastDate: DateTime(2026));
            if (picked != null && picked != controller.date) {
              controller.date = picked;
              controller.update();
            }
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.close),
                color: Colors.black,
                onPressed: () {
                  Get.back();
                },
              ),
              title: const Text('Add Transaction'),
            ),
            body: Container(
              color: AppColors.background,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.money,
                                color: Colors.orange,
                                size: 35,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  controller.onChanged(value);
                                },
                                controller: controller.textcontroller,
                                decoration: const InputDecoration(
                                  hintText: '0',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Colors.orange), // Màu sắc đường kẻ
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.question_mark_rounded,
                                size: 35,
                                color: Colors.orange,
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: DropdownButton<String>(
                                underline: const SizedBox.shrink(),
                                value: controller.type,
                                style: const TextStyle(
                                  color: Colors.black87, // Set text color
                                  fontSize: 16, // Set font size
                                  fontWeight:
                                      FontWeight.bold, // Set font weight
                                ),
                                items: ListIcon.map((ItemIcon item) {
                                  return DropdownMenuItem<String>(
                                      value: item.title,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: item.img,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                            height: 25,
                                          ),
                                          Text(titleOf(item.title, context) ??
                                              ''),
                                        ],
                                      ));
                                }).toList(),
                                onChanged: (value) {
                                  controller.type = value!;
                                  // print(controller.type); Đã lấy được type
                                  controller.update();
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: const Icon(
                                Icons.text_fields,
                                size: 35,
                                color: Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                    hintText: 'Write note'),
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                onChanged: (value) {
                                  controller.note = value;
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            datePicker();
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 15),
                                child: const Icon(
                                  Icons.calendar_month,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    height: 50,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      DateTime.now().day == controller.date.day
                                          ? "Today"
                                          : DateTime.now()
                                                      .subtract(
                                                          Duration(days: 1))
                                                      .day ==
                                                  controller.date.day
                                              ? "Yesterday"
                                              : DateTime.now()
                                                          .add(
                                                              Duration(days: 1))
                                                          .day ==
                                                      controller.date.day
                                                  ? "Tomorrow"
                                                  : Common.formatToDay(
                                                      controller.date),
                                      // "Today",
                                      style: AppStyles.titleText16_500,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // width: 100,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                          onPressed: controller.value == 0
                              ? null
                              : () async {
                                  await controller.updateExpense(
                                      controller.id,
                                      controller.value,
                                      controller.type,
                                      controller.note,
                                      1,
                                      controller.date);
                                  Get.find<TransactionLogic>().resetData();
                                  Get.back();
                                },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (controller.value == 0 ||
                                  controller.value == "") {
                                return null; // Màu mặc định
                              } else {
                                return AppColors
                                    .green; // Màu xanh khi điều kiện thỏa mãn
                              }
                            }),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: controller.value == 0
                                  ? null
                                  : AppColors.backbutton1,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
