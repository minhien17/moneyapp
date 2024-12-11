import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/page/add_expense/add_expense_page.dart';
import 'package:moneyapp/main/page/edit_expense/edit_expense_page.dart';
import 'package:moneyapp/main/page/main_page.dart';
import 'package:moneyapp/main/page/transaction/transaction_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor:
              Color.fromARGB(255, 40, 232, 158), // Màu nền của AppBar
          titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 93, 85, 85),
              fontSize: 20), // Màu và kích thước chữ tiêu đề AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 229, 237, 229),
            onPrimary: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
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
      locale: Locale('en'),
    );
  }
}
