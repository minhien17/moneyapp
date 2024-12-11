import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Icon.dart';
import 'package:moneyapp/main/model/ListIcon.dart';
import 'package:moneyapp/main/page/add_expense/add_expense_logic.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExpenseLogic>(
        init: AddExpenseLogic(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Expense'),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
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
                                  color: Colors.orange), // Màu sắc đường kẻ
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: DropdownButton<String>(
                          underline: SizedBox.shrink(),
                          value: controller.type,
                          style: const TextStyle(
                            color: Colors.black87, // Set text color
                            fontSize: 16, // Set font size
                            fontWeight: FontWeight.bold, // Set font weight
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
                                    SizedBox(
                                      width: 20,
                                      height: 25,
                                    ),
                                    Text(titleOf(item.title, context) ?? ''),
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
                          decoration:
                              const InputDecoration(hintText: 'Write note'),
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
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          addExpense(controller.value, controller.type,
                              controller.note);
                          // Get.offAll(MainPage(), transition: Transition.fadeIn);

                          Get.back();
                        },
                        child: const Text('Add')),
                  )
                ],
              ),
            ),
          );
        });
  }

  void addExpense(int value, String type, String note) {
    DatabaseService databaseService = DatabaseService.instance;
    print(type);
    databaseService.addExpense(value, type, note);
  }
}
