import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';

class HomePage extends StatelessWidget {
  final RxString totalExpense = '5,000,000 đ'.obs;
  final RxBool isTotalVisible = true.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey.withOpacity(0.02),
      // padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Container(

          Expanded(
              child: Container(
            color: Colors.grey.withOpacity(0.02),
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                MainNotification(),
                const SizedBox(height: 10),
                Wallet(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Report this month",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 20,
                    ),
                  ),
                ),
                Report(),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget MainNotification() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      totalExpense.value,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                          onPressed: visibleForTotalExpense,
                          icon: Icon(Icons.visibility))),
                ],
              ),
              Text(
                "Total balance",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 18,
                ),
              )
            ],
          )),
          Icon(
            Icons.notifications,
          )
        ],
      ),
    );
  }

  Widget Report() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        // Để tạm làm const
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "Total spent",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text("3,636,000"),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    "Total income",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text("3,500,000"),
                ],
              ),
            ],
          ),
          Text('Ve bieu do'),
          // Image.asset(
          //   'images/img.png',
          //   width: 400,
          //   height: 200,
          //   fit: BoxFit.cover,
          // ),
          // Image.asset(
          //   'images/img.png',
          //   width: 400,
          //   height: 200,
          //   fit: BoxFit.cover,
          // )
        ],
      ),
    );
  }

  Widget Wallet() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                    "My wallets"),
              ),
              Text(
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.lightGreen,
                  ),
                  "See all"),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(
                    Icons.wallet,
                    size: 45,
                    color: Colors.green,
                  ),
                  Text(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      "Tiền mặt"),
                  Spacer(),
                  Text(
                    "2,000,000 đ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void visibleForTotalExpense() {
    isTotalVisible.value = !isTotalVisible.value;
    if (isTotalVisible.value) {
      totalExpense.value = "5,000,000 đ";
    } else {
      totalExpense.value = "- - - - - - - - -";
    }
  }
}
