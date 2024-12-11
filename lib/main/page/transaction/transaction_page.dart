import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/Expense.dart';
import 'package:moneyapp/main/model/ListIcon.dart';
import 'package:moneyapp/main/page/transaction/transaction_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionPage extends GetView<TransactionLogic> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionLogic>(
        init: TransactionLogic(),
        builder: (controller) {
          return Scaffold(
              body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Header(context),
                SizedBox(
                  height: 20,
                ),
                Report(),

                // List Expense
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white54,
                      child: ListView.builder(
                        itemCount: controller.lists.length,
                        itemBuilder: (context, index) {
                          Expense expense = controller.lists[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Màu viền
                                width: 0.3, // Độ dày của viền
                              ),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Bo góc viền (nếu cần)
                            ),
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    titleOf(expense.type, context) ?? "",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Center(child: Text(expense.note)),
                              leading: itemLeading(expense.type),
                              trailing: Text(
                                "${expense.value}",
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontSize: 17,
                                ),
                              ),
                              onTap: () async {
                                await Get.toNamed(
                                  "/detail",
                                  arguments: {
                                    'id': expense.id,
                                    'value': expense.value,
                                    'type': expense.type,
                                    'note': expense.note
                                  },
                                );
                              },
                              onLongPress: () {
                                controller.deleteExpense(expense.id);
                              },
                            ),
                          );
                        },
                      )),
                ),
              ],
            ),
          ));
        });
  }

  Widget Header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 110,
        ),
        Column(
          children: [
            Text(
              AppLocalizations.of(context)!.textbalance,
              style: TextStyle(
                fontSize: 17,
                color: Colors.black26,
              ),
            ),
            Text(
              '1,550,000 đ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(Icons.wallet_giftcard_sharp),
          ],
        ),
        Spacer(),
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.defaultDialog(title: "Updating..."),
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.defaultDialog(title: "Updating..."),
                  icon: Icon(Icons.more_vert),
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            )
          ],
        )
      ],
    );
  }

  Widget Report() {
    return Column(
      children: [
        Container(
          height: 30,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                height: 30,
                width: 100,
                child: Text('02/2024'),
              ),
              Container(
                height: 30,
                width: 100,
                child: Text('03/2024'),
              ),
              Container(
                height: 30,
                width: 100,
                child: Text('03/2024'),
              ),
              Container(
                height: 30,
                width: 100,
                child: Text('03/2024'),
              ),
              Container(
                height: 30,
                width: 100,
                child: Text('03/2024'),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Inflow'),
                  Spacer(),
                  Text('0'),
                ],
              ),
              Row(
                children: [
                  Text('Outflow'),
                  Spacer(),
                  Text('2,296,000'),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Text('-2,296,000'),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(0),
          child: ElevatedButton(
            onPressed: () {
              Get.offAllNamed('/');
              // print(Get.arguments);
            },
            child: const Text(
              'View report for this period',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 82, 249, 88),
                // backgroundColor: Color.fromARGB(255, 254, 141, 141)
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Image? itemLeading(String type) {
  for (int i = 0; i < ListIcon.length; i++) {
    if (ListIcon[i].title == type) {
      return ListIcon[i].img;
    }
  }
}
