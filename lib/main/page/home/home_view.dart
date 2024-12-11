import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/page/home/home_logic.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
        init: HomeLogic(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      controller.isVisible == true
                          ? "${controller.totalExpense} đ"
                          : "---------------",
                      style: TextStyle(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () => controller.changeVisible(),
                        icon: controller.isVisible == true
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off))
                  ],
                ),
              ]),
            ),
          );
        });
  }
}
