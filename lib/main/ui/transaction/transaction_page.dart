import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:moneyapp/database/Database.dart';
import 'package:moneyapp/main/model/transaction_model.dart';
import 'package:moneyapp/main/model/ListIcon.dart';
import 'package:moneyapp/main/ui/transaction/transaction_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moneyapp/main/utils/common.dart';
import 'package:moneyapp/res/app_colors.dart';
import 'package:moneyapp/res/app_styles.dart';

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionLogic>(
        init: TransactionLogic(),
        builder: (controller) {
          double width = MediaQuery.of(context).size.width;
          List<Container> containers = [];
          if (controller.lists.isNotEmpty) {
            containers =
                controller.lists.asMap().entries.map<Container>((entry) {
              int index = entry.key;
              Transaction expense = entry.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.only(
                    right: 20, left: 20, bottom: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.line, // Màu của viền
                    width: 1, // Độ dày của viền
                  ),
                  // borderRadius: BorderRadius.circular(10), // Tạo góc bo tròn cho viền
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateTime.parse(expense.date).day.toString(),
                          style: AppStyles.title.copyWith(fontSize: 22),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          Common.formatToMonthYear(
                              DateTime.parse(expense.date)),
                          style: AppStyles.grayText14_400,
                        ),
                        Spacer(),
                        Text(
                          Common.formatNumber("-${expense.value}"),
                          style: AppStyles.leadingText18_400
                              .copyWith(fontSize: 16),
                        )
                      ],
                    ),
                    Divider(
                      height: 16,
                      thickness: 0.5,
                      color: AppColors.line,
                    ),
                    InkWell(
                      child: Row(children: [
                        itemLeading(expense.type)!,
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 200,
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                titleOf(expense.type, context) ?? "",
                                style: AppStyles.leadingText18_400,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                expense.note,
                                style: AppStyles.grayText14_400,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          Common.formatNumber("${expense.value}"),
                          style: AppStyles.redText16,
                        )
                      ]),
                      onLongPress: () {
                        controller.deleteExpense(expense.id);
                        controller.resetData();
                      },
                      onTap: () async {
                        await Get.toNamed(
                          "/detail",
                          arguments: {
                            'id': expense.id,
                            'value': expense.value,
                            'type': expense.type,
                            'note': expense.note,
                            'date': expense.date
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList();
          }
          return Scaffold(
              backgroundColor: AppColors.background,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    toolbarHeight: 150,
                    flexibleSpace: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 15, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width / 3,
                              ),
                              Container(
                                width: width / 3,
                                child: Column(
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)!
                                            .textbalance,
                                        style: AppStyles.grayText15_400),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      Common.formatNumber(
                                          "${controller.income - controller.totalExpense}"),
                                      style: AppStyles.titleText18_500,
                                    ),
                                    const SizedBox(
                                        height: 30,
                                        child:
                                            Icon(Icons.wallet_giftcard_sharp)),
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: width / 3 - 10,
                                alignment: Alignment.topRight,
                                child: Row(
                                  children: [
                                    Spacer(),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: IconButton(
                                        onPressed: () => Get.defaultDialog(
                                            title: "Updating..."),
                                        icon: const Icon(
                                          Icons.search,
                                          color: AppColors.title,
                                          weight: 800,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: IconButton(
                                        onPressed: () => Get.defaultDialog(
                                            title: "Updating..."),
                                        icon: const Icon(
                                          Icons.more_vert,
                                          color: AppColors.title,
                                          weight: 800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: 40,
                            margin: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.months.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: width / 3,
                                    // padding: EdgeInsets.only(right: 40),
                                    child: InkWell(
                                      onTap: () {
                                        print(controller.months[index]);
                                      },
                                      child: Center(
                                        child: Text(
                                          controller.months[index],
                                          style: AppStyles.leadingText18_400,
                                        ),
                                      ),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(
                            color: AppColors.line, // Màu của đường viền
                            width: 0.5, // Độ dày của đường viền
                          ),
                        ),
                      ),
                      //
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textInflow,
                                style: AppStyles.grayText15_400,
                              ),
                              const Spacer(),
                              Text(
                                "${controller.income}",
                                style: AppStyles.blueText16_500,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textOutflow,
                                style: AppStyles.grayText15_400,
                              ),
                              const Spacer(),
                              Text(
                                Common.formatNumber(
                                    "${controller.totalExpense}"),
                                style: AppStyles.redText18,
                              )
                            ],
                          ),
                          Divider(
                            height: 16,
                            thickness: 0.5,
                            indent: width / 2,
                            color: AppColors.line,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                Common.formatNumber(
                                    "${controller.income - controller.totalExpense}"),
                                style: AppStyles.titleText16_500,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors
                                    .backbutton1, // Sử dụng trực tiếp Color từ int
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Bo cong 20 pixel
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.offAllNamed('/');
                              // print(Get.arguments);
                            },
                            child: const Text(
                              'View report for this period',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.green,
                                // backgroundColor: Color.fromARGB(255, 254, 141, 141)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // List Expense
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      color: AppColors.background,
                      child: Column(
                        children: [...containers],
                      ),
                    ),
                  ]))
                ],
              ));
        });
  }
}

Image? itemLeading(String type) {
  for (int i = 0; i < ListIcon.length; i++) {
    if (ListIcon[i].title == type) {
      return ListIcon[i].img;
    }
  }
}
