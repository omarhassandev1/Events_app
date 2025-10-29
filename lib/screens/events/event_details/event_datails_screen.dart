import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:evently_application/screens/events/event_details/event_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/app_localizations.dart';
import '../../../provider/settings_provider.dart';
import '../edit_event/edit_event_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String? _style;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel =
        CategoryModel.categories
            .where((e) => e.id == widget.eventModel.catId)
            .first;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.eventDescription),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              spacing: 8,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                EditEventScreen(eventModel: widget.eventModel),
                      ),
                    );
                  },
                  child: Assets.svg.editIcon.svg(),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            title: Text(
                              AppLocalizations.of(context)!.deleteEvent,
                              style: TextStyle(
                                color: AppColors.errorColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              AppLocalizations.of(context)!.areYouSure,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  AppLocalizations.of(context)!.cancel,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.errorColor,
                                  foregroundColor: AppColors.lightBg,
                                ),
                                onPressed: () {
                                  Provider.of<EventProvider>(
                                    context,
                                    listen: false,
                                  ).removeEvent(widget.eventModel);
                                  Provider.of<UserProvider>(
                                    context,
                                    listen: false,
                                  ).removeFavEvent(widget.eventModel.id!);

                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.delete,
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  child: Assets.svg.deleteIcon.svg(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    categoryModel.image!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  widget.eventModel.title,
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.eventModel.date.split(' ').first,
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(color: AppColors.mainColor),
                          ),
                          Text(
                            widget.eventModel.date.split(' ').last,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EventMap(eventModel: widget.eventModel),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.mainColor),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.mainColor,
                          ),
                          child: Icon(
                            Icons.gps_fixed_rounded,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Text(
                          widget.eventModel.locationName.isNotEmpty
                              ? widget.eventModel.locationName
                              : AppLocalizations.of(context)!.location,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: AppColors.mainColor),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GoogleMap(
                      style: _style,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          widget.eventModel.latitude,
                          widget.eventModel.longitude,
                        ),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('event_location'),
                          position: LatLng(
                            widget.eventModel.latitude,
                            widget.eventModel.longitude,
                          ),
                          infoWindow: InfoWindow(
                            title: widget.eventModel.title,
                          ),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      mapType: MapType.normal,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.eventModel.description,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map_style/style.json',
    );
    setState(() {
      if (Provider.of<SettingsProvider>(context).themeMode == ThemeMode.dark) {
        _style = style;
      }
    });
  }
}
