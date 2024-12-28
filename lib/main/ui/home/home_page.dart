import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/ui/home/home_logic.dart';
import 'package:moneyapp/main/utils/common.dart';
import 'package:moneyapp/res/app_colors.dart';
import 'package:moneyapp/res/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
        init: HomeLogic(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        controller.isVisible == true
                            ? "${Common.formatNumber(controller.totalExpense.toString())} đ"
                            : "*********",
                        style: AppStyles.title,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () => controller.changeVisible(),
                          icon: controller.isVisible == true
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      Spacer(),
                      Icon(Icons.notifications)
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.texttotalbalance,
                        style: AppStyles.grayText15_400,
                      ),
                      Icon(
                        Icons.question_mark_rounded,
                        color: AppColors.grayText,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.textmywallet,
                            style: AppStyles.titleText18_500,
                          ),
                          Spacer(),
                          Text(
                            AppLocalizations.of(context)!.textseeall,
                            style: AppStyles.linkText16_500,
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: AppColors.grayText,
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/wallet.png",
                            height: 50,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!.textcash,
                            style: AppStyles.titleText16_500,
                          ),
                          Spacer(),
                          Text(
                            "${Common.formatNumber(controller.totalExpense.toString())} đ",
                            style: AppStyles.titleText16_500,
                          )
                        ],
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.textReportThisMonth,
                        style: AppStyles.grayText16_700,
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of(context)!.textSeeReports,
                        style: AppStyles.linkText16_500,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      children: [
                        TabBar(controller: controller.tabController, tabs: [
                          Tab(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.textTotalSpent,
                                  style: AppStyles.grayText15_400,
                                ),
                                Text(
                                  ("3,171,000"),
                                  style: AppStyles.redText16,
                                )
                              ],
                            ),
                          ),
                          Tab(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.textTotalIncome,
                                style: AppStyles.grayText15_400,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                "0",
                                style: AppStyles.blueText16_500,
                              )
                            ],
                          ))
                        ]),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                Center(
                                  child: Text("Chart 1"),
                                ),
                                Center(
                                  child: Text("Chart 2"),
                                ),
                              ]),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
