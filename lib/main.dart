import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/services/setting_service.dart';
import 'package:moneyapp/main/ui/add_expense/add_expense_page.dart';
import 'package:moneyapp/main/ui/edit_expense/edit_expense_page.dart';
import 'package:moneyapp/main/ui/main_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moneyapp/main/utils/shared_preference.dart';
import 'package:moneyapp/res/app_colors.dart';

import 'main/ui/transaction/transaction_logic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  runApp(const MyApp());
}

Future initServices() async {
  await Get.putAsync(() => SettingService().init());
  Get.put(TransactionLogic()); // put vào để dùng
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        // primaryColor: AppColors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Màu nền của AppBar
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 93, 85, 85),
              fontSize: 20), // Màu và kích thước chữ tiêu đề AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.background,
            onPrimary: AppColors.grayText,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),

        colorScheme: const ColorScheme.light(
          primary: AppColors.green,
          // onSurface: AppColors.green,
          // onPrimary: Colors.white, // Màu của văn bản trên tiêu đề
          // background: AppColors.green,
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/add', page: () => AddExpense()),
        // GetPage(name: '/transaction', page: () => TransactionPage()),
        GetPage(name: '/detail', page: () => EditExpense()),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Get.find<SettingService>().locale,
    );
  }
}
