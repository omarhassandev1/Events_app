import 'package:flutter/material.dart';
// 1. اعمل امبورت لملف الترجمة بتاعك
// (المسار ده ممكن يختلف حسب مشروعك)

import '../gen/assets.gen.dart';
import '../generated/app_localizations.dart';

class CategoryModel {
  int id;
  IconData icon;
  String? image;

  CategoryModel({
    required this.id,
    required this.icon,
    this.image,
  });

  String getLocalizedTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (id) {
      case 1:
        return l10n.all;
      case 2:
        return l10n.sport;
      case 3:
        return l10n.birthday;
      case 4:
        return l10n.meeting;
      case 5:
        return l10n.workshop;
      case 6:
        return l10n.eating;
      default:
        return l10n.all;
    }
  }

  static List<CategoryModel> get categories => [
    CategoryModel(id: 1, icon: Icons.explore_outlined,),
    CategoryModel(id: 2, icon: Icons.pedal_bike,image: Assets.images.eventSport.path),
    CategoryModel(id: 3, icon: Icons.cake,image: Assets.images.eventBirthday.path),
    CategoryModel(id: 4, icon: Icons.meeting_room,image: Assets.images.eventMeating.path),
    CategoryModel(id: 5, icon: Icons.handyman,image: Assets.images.eventWorkshop.path),
    CategoryModel(id: 6, icon: Icons.dining,image: Assets.images.eventEating.path),
  ];
}