import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_text_field.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:evently_application/screens/home/home_tab/views/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../generated/app_localizations.dart';
import '../../../models/event_model.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key,});
  static const String routeName = '/favoriteScreen';

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {

    UserModel? userModel = Provider.of<UserProvider>(context).userModel;
    List<EventModel>? filteredEvents = getFilteredFavEvents(userModel);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextField(
              hintText: AppLocalizations.of(context)!.searchForEvents,
              prefixIcon: Icon(Icons.search, color: AppColors.mainColor),
              borderColor: AppColors.mainColor,
              hintColor: AppColors.mainColor,
              onChanged: (value){
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(child: EventsListView(events: filteredEvents ?? [])),
        ],
      ),
    );
  }

  List<EventModel> getFilteredFavEvents(UserModel? userModel) {
    if (userModel == null || userModel.favEvents == null) return [];

    return userModel.favEvents!
        .where((event) =>
        event.title.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }
}
