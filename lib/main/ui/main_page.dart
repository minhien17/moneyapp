import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/ui/Account.dart';
import 'package:moneyapp/main/ui/Budget.dart';
import 'package:moneyapp/main/ui/add_expense/add_expense_page.dart';
import 'package:moneyapp/main/ui/main_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moneyapp/main/ui/transaction/transaction_logic.dart';
import 'package:moneyapp/main/ui/transaction/transaction_page.dart';
import 'package:moneyapp/res/app_colors.dart';

import 'home/home_page.dart';

class MainPage extends GetWidget {
  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TransactionPage(),
    AddExpense(), // không gọi đến vì mình chuyển page
    Budget(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<MainLogic>(
        init: MainLogic(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: _widgetOptions[controller.index],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.index,
              onTap: (index) {
                if (index == 2) {
                  Get.to(AddExpense())!.then((_) {
                    controller.setIndex(1);
                  });
                } else {
                  controller.update();
                  controller.setIndex(index);
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: AppLocalizations.of(context)!.texthome),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.wallet,
                    ),
                    label: AppLocalizations.of(context)!.texttransaction),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                    label: AppLocalizations.of(context)!.textadd),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.request_page_outlined,
                    ),
                    label: AppLocalizations.of(context)!.textbudget),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    label: AppLocalizations.of(context)!.textaccount),
              ],
              selectedItemColor: AppColors.title,
              unselectedItemColor: AppColors.grayText,
              selectedLabelStyle: const TextStyle(color: AppColors.title),
              unselectedLabelStyle: const TextStyle(
                color: AppColors.grayText,
              ),
              showUnselectedLabels: true,
            ),
          );
        });
  }
}
