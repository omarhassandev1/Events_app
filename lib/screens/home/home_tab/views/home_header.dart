import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../models/user_model.dart';
import '../../../../provider/user_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});


  @override
  Widget build(BuildContext context) {
  UserModel userModel = Provider.of<UserProvider>(context).userModel!;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      padding: EdgeInsets.all(16),
      child: SafeArea(
        child: Column(
          spacing: 10,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back ✨',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.lightBg,
                      ),
                    ),
                    Text(
                      userModel.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBg,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.brightness_5_sharp,
                        color: AppColors.lightBg,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.lightBg,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(
                          'En',
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).bottomNavigationBarTheme.backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 5,
              children: [
                Assets.svg.locationOutlined.svg(),
                Text(
                  'Cairo , Egypt',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.lightBg,
                  ),
                ),
              ],
            ),
            FilterView(),
          ],
        ),
      ),
    );
  }
}

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedId = Provider.of<EventProvider>(context).selectedCatId;
    List<CategoryModel> categories = CategoryModel.categories;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          CategoryModel currentCategory = categories[index];
          bool isSelected = selectedId == currentCategory.id;
          return Theme(
            data: Theme.of(context).copyWith(cardColor: Colors.transparent),
            child: FilterChip(
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              showCheckmark: false,
              label: Row(
                spacing: 5,
                children: [
                  Icon(
                    currentCategory.icon,
                    color:
                        isSelected
                            ? Theme.of(context).cardColor
                            : AppColors.lightBg,
                  ),
                  Text(
                    currentCategory.title,
                    style: TextStyle(
                      color:
                          isSelected
                              ? Theme.of(context).cardColor
                              : AppColors.lightBg,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              onSelected: (value) {
                Provider.of<EventProvider>(context,listen: false).editSelectedId(currentCategory.id);
              },
              selected: isSelected,
              selectedColor: Theme.of(context).focusColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(46),
              ),
              side:
                  isSelected
                      ? null
                      : BorderSide(color: Theme.of(context).focusColor),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 5),
      ),
    );
  }
}
