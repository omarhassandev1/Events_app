import 'package:evently_application/models/category_model.dart';
import 'package:flutter/material.dart';

import '../../../common/theme/app_colors.dart';

class CategorySelectorView extends StatelessWidget {
  const CategorySelectorView({
    super.key,
    required this.selectedCategory,
    required this.onChanged,
  });

  final CategoryModel selectedCategory;
  final void Function(CategoryModel) onChanged;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = CategoryModel.categories.sublist(1);
    return Column(
      spacing: 16,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            selectedCategory.image!,
            height: MediaQuery.of(context).size.height*0.26,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel currentCategory = categories[index];
              bool isSelected = selectedCategory.id == currentCategory.id;
              return FilterChip(
                backgroundColor:
                    isSelected
                        ? AppColors.mainColor
                        : Theme.of(context).scaffoldBackgroundColor,
                showCheckmark: false,
                label: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      currentCategory.icon,
                      color:
                          isSelected
                              ? Theme.of(context).scaffoldBackgroundColor
                              : AppColors.mainColor,
                    ),
                    Text(
                      currentCategory.title,
                      style: TextStyle(
                        color:
                            isSelected
                                ? Theme.of(context).scaffoldBackgroundColor
                                : AppColors.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onSelected: (value) {
                  if (value) {
                    onChanged(currentCategory);
                  }
                },
                selected: isSelected,
                selectedColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(46),
                ),
                side:
                    isSelected ? null : BorderSide(color: AppColors.mainColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
