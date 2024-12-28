import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/services/setting_service.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accont'),
        actions: [
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                onTap: () {
                  Get.updateLocale(Locale('en'));
                  Get.find<SettingService>().saveLocale('en');
                },
                value: 'en',
                child: Text('English'),
              ),
              PopupMenuItem(
                child: Text("Việt Nam"),
                onTap: () {
                  Get.updateLocale(Locale('vi'));
                  Get.find<SettingService>().saveLocale('vi');
                },
                value: 'vi',
              )
            ];
          })
        ],
      ),
      body: Text('data'),
    );
  }
}
