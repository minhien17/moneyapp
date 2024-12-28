import 'package:flutter/material.dart';
import 'package:moneyapp/main/model/Icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<ItemIcon> ListIcon = [
  ItemIcon(
      img: Image.asset(
        'assets/icons/food.png',
        height: 30,
        width: 30,
      ),
      title: 'food',
      description: "Food & Drink"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/donation.png',
        height: 30,
        width: 30,
      ),
      title: 'donation',
      description: "Donation & Gift"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/education.png',
        height: 30,
        width: 30,
      ),
      title: 'education',
      description: "Education"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/entertain.png',
        height: 30,
        width: 30,
      ),
      title: 'entertainment',
      description: "Entertainment"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/family.png',
        height: 30,
        width: 30,
      ),
      title: 'family',
      description: "Family & Love"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/home.png',
        height: 30,
        width: 30,
      ),
      title: 'home',
      description: "Home Service"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/transportation.png',
        height: 30,
        width: 30,
      ),
      title: 'transportation',
      description: "Transportation"),
  ItemIcon(
      img: Image.asset(
        'assets/icons/other.png',
        height: 30,
        width: 30,
      ),
      title: 'other',
      description: "Other Expense"),
];

// định nghĩa description cho List Icon khi map với icon

String? titleOf(String type, BuildContext context) {
  for (int i = 0; i < ListIcon.length; i++) {
    if (ListIcon[i].title == type) {
      if (type == 'food') {
        return AppLocalizations.of(context)!.textfoodanddrink;
      } else if (type == 'donation') {
        return AppLocalizations.of(context)!.textdonation;
      } else if (type == 'education') {
        return AppLocalizations.of(context)!.texteducation;
      } else if (type == 'entertainment') {
        return AppLocalizations.of(context)!.textentertainment;
      } else if (type == 'family') {
        return AppLocalizations.of(context)!.textfamily;
      } else if (type == 'home') {
        return AppLocalizations.of(context)!.texthomeservice;
      } else if (type == 'transportation') {
        return AppLocalizations.of(context)!.texttransportation;
      } else {
        return AppLocalizations.of(context)!.textotherexpense;
      }
    }
  }
}
