import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';

class CategoryModel {
  int id;
  String title;
  IconData icon;
  String? image;
  CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    this.image,
  });

  static List<CategoryModel> get categories => [
    CategoryModel(id: 1, title: 'All', icon: Icons.explore_outlined,),
    CategoryModel(id: 2, title: 'Sport', icon: Icons.pedal_bike,image: Assets.images.eventSport.path),
    CategoryModel(id: 3, title: 'Birthday', icon: Icons.cake,image: Assets.images.eventBirthday.path),
    CategoryModel(id: 4, title: 'Meeting', icon: Icons.meeting_room,image: Assets.images.eventMeeting.path),
    CategoryModel(id: 5, title: 'Workshop', icon: Icons.handyman,image: Assets.images.eventWorkshop.path),
    CategoryModel(id: 6, title: 'Eating', icon: Icons.dining,image: Assets.images.eventMeeting.path),
  ];
}
