import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_text_field.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:evently_application/screens/home/home_tab/views/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_main_button.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});
  static const String routeName = '/favoriteScreen';
  @override
  Widget build(BuildContext context) {
    UserModel? userModel = Provider.of<UserProvider>(context).userModel;
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
          Expanded(child: EventsListView(events: userModel?.favEvents??[]))
        ],
      ),
    );
  }
}
