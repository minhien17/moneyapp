import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Icon.dart';
import 'package:moneyapp/main/model/ListIcon.dart';
import 'package:moneyapp/main/page/edit_expense/edit_expense_logic.dart';

class EditExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Get.back(),
          ),
          title: Text('Detail'),
        ),
        body: GetBuilder<EditExpenseLogic>(
          init: EditExpenseLogic(),
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
                      child: const Icon(
                        Icons.money,
                        size: 35,
                        color: Colors.orange,
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: controller.textcontroller,
                      onChanged: (value) {
                        controller.onChanged(value);
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                          hintText: '0',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                          ))),
                      keyboardType: TextInputType.number,
                    )),
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
                        items: ListIcon.map((ItemIcon item) {
                          return DropdownMenuItem<String>(
                            value: item.title,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: item.img,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  item.description,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.type = value!;
                          controller.update();
                        },
                      ),
                    )
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
                      controller: TextEditingController(text: controller.note),
                      decoration:
                          const InputDecoration(hintText: 'Note something'),
                      style: const TextStyle(fontSize: 18),
                      onChanged: (value) {
                        controller.note = value;
                      },
                    ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orangeAccent)),
                      onPressed: () {
                        updateExpense(controller.id, controller.value,
                            controller.type, controller.note);
                        Get.toNamed('/', arguments: 1);
                      },
                      child: Text('Save')),
                )
              ]),
            );
          },
        ));
  }

  void updateExpense(int id, int value, String type, String note) {
    DatabaseService databaseService = DatabaseService.instance;
    databaseService.updateExpense(id, value, type, note);
  }
}
