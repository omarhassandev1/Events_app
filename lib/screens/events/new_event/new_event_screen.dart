import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_main_button.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/screens/events/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../generated/app_localizations.dart';
import '../../../provider/events_provider.dart';
import 'map_picker_screen.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  static const routeName = '/newEvent';

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  CategoryModel selectedCategory = CategoryModel.categories[1];
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LatLng? _selectedLocation;
  String? _locationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createEvent)),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  CategorySelectorView(
                    selectedCategory: selectedCategory,
                    onChanged: (category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  CustomTextField(
                    controller: titleController,
                    label: AppLocalizations.of(context)!.title,
                    hintText: 'Event title',
                    prefixIcon: Icon(Icons.edit_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The title is required';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: descriptionController,
                    label: AppLocalizations.of(context)!.description,
                    hintText: AppLocalizations.of(context)!.eventDescription,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The title is required';
                      }
                      return null;
                    },
                  ),
                  Column(
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.date_range,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                          Text(
                            AppLocalizations.of(context)!.eventDate,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Spacer(),
                          TextButton(
                            child: Text(
                              _getDateText(),
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                initialDate: selectedDate,
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (date != null) {
                                setState(() {
                                  selectedDate = date;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.access_time,
                            color:
                                Theme.of(context).textTheme.titleMedium!.color,
                          ),
                          Text(
                            AppLocalizations.of(context)!.eventTime,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Spacer(),
                          TextButton(
                            child: Text(
                              _getTimeText(),
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            onPressed: () async {
                              TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() {
                                  selectedTime = time;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      final pickedLocation = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapPickerScreen(),
                        ),
                      );

                      if (pickedLocation != null) {
                        setState(() {
                          _selectedLocation = LatLng(
                            pickedLocation['lat'],
                            pickedLocation['lng'],
                          );
                          _locationName = pickedLocation['name'];
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              Icons.my_location_rounded,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          Text(
                            _locationName ??
                                AppLocalizations.of(
                                  context,
                                )!.chooseEventLocation,
                            style: Theme.of(context).textTheme.titleMedium!
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
                  SafeArea(
                    child: CustomMainButton(
                      text: AppLocalizations.of(context)!.save,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedDate == null || selectedTime == null) {
                            Fluttertoast.showToast(
                              msg: 'Date and time are required!',
                              backgroundColor: Colors.red,
                            );
                            return;
                          }

                          if (_selectedLocation == null) {
                            Fluttertoast.showToast(
                              msg: 'Location is required!',
                              backgroundColor: Colors.red,
                            );
                            return;
                          }

                          selectedDate = selectedDate!.copyWith(
                            hour: selectedTime!.hour,
                            minute: selectedTime!.minute,
                          );

                          EventModel eventModel = EventModel(
                            title: titleController.text,
                            date: DateFormat('yyyy-MM-dd hh:mm').format(selectedDate!),
                            description: descriptionController.text,
                            isFav: false,
                            catId: selectedCategory.id,
                            latitude: _selectedLocation!.latitude,
                            longitude: _selectedLocation!.longitude,
                            locationName: _locationName!
                          );

                          try {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => Center(
                                child: Container(
                                  padding: const EdgeInsets.all(40),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const CircularProgressIndicator(),
                                ),
                              ),
                            );

                            await Provider.of<EventProvider>(context, listen: false)
                                .addEvent(eventModel);

                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: 'Event added successfully!',
                              backgroundColor: Colors.green,
                            );
                            Navigator.of(context).pop();
                          } catch (e) {
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: 'Error: $e',
                              backgroundColor: Colors.red,
                            );
                          }
                        }
                      },

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeText() {
    if (selectedTime == null) {
      return AppLocalizations.of(context)!.selectTime;
    }
    return selectedTime!.format(context);
  }

  String _getDateText() {
    if (selectedDate == null) {
      return AppLocalizations.of(context)!.selectDate;
    }
    return DateFormat.yMEd().format(selectedDate!);
  }
}
