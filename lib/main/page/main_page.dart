import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/page/Account.dart';
import 'package:moneyapp/main/page/Budget.dart';
import 'package:moneyapp/main/page/add_expense/add_expense_page.dart';
import 'package:moneyapp/main/page/main_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moneyapp/main/page/transaction/transaction_logic.dart';
import 'package:moneyapp/main/page/transaction/transaction_page.dart';

import 'home/home_view.dart';

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
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.index,
              onTap: (index) {
                if (index == 2) {
                  Get.to(AddExpense())!.then((_) {
                    if (!Get.isRegistered<TransactionLogic>()) {
                      // Nếu chưa tạo, thì tạo mới instance của TransactionLogic
                      Get.create<TransactionLogic>(() => TransactionLogic());
                    } else {
                      // Nếu đã tạo rồi, chỉ cần gọi resetData() để làm mới dữ liệu
                      Get.find<TransactionLogic>().resetData();
                    }

                    // Sau đó, cập nhật chỉ số trang
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

              selectedItemColor:
                  const Color.fromARGB(255, 45, 40, 40), // Màu khi được chọn
              unselectedItemColor: const Color.fromARGB(86, 83, 79, 79),
              selectedLabelStyle:
                  const TextStyle(color: Color.fromARGB(255, 45, 40, 40)),
              unselectedLabelStyle: const TextStyle(
                color: Color.fromARGB(86, 83, 79, 79),
              ),
              showUnselectedLabels: true,
            ),
          );
        });
  }
}
