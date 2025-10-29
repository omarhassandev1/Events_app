import 'package:flutter/material.dart';

import '../../../../common/theme/app_colors.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../models/category_model.dart';
import '../../../../models/event_model.dart';

class EventLocationCard extends StatelessWidget {
  const EventLocationCard({
    super.key,
    required this.event, required this.isSelected,
  });

  final EventModel event;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {

    int catId = event.catId;
    CategoryModel category = CategoryModel.categories.where((e)=>e.id==catId).first;
    category.image;
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected? AppColors.mainColor: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mainColor),
      ),
      child: Row(
        spacing: 8,
        children: [
          Expanded(child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(category.image!,fit: BoxFit.cover,))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,color: isSelected?AppColors.lightBg:null),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Assets.svg.locationOutlined.svg(colorFilter: ColorFilter.mode((isSelected?AppColors.lightBg:AppColors.mainColor), BlendMode.srcIn)),
                    Expanded(
                      child: Text(
                        event.locationName,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500, color: isSelected?AppColors.lightBg:null),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
