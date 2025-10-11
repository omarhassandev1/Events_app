import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_text_field.dart';
import 'package:evently_application/common/widgets/event_card.dart';
import 'package:evently_application/screens/home/home_tab/views/events_list_view.dart';
import 'package:flutter/material.dart';

import '../../../models/event_model.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<EventModel> events = List.generate(
      4,
      (index) => EventModel(
        title: 'title $index',
        date: '22\nDec',
        description: 'description',
        isFav: index / 2 == 0,
        catId: index+2,
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: 'Search for Event',
              prefixIcon: Icon(Icons.search, color: AppColors.mainColor),
              borderColor: AppColors.mainColor,
              hintColor: AppColors.mainColor,
            ),
          ),
          EventsListView(events: events)
        ],
      ),
    );
  }
}
