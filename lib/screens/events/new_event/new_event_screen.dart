import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_main_button.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/screens/events/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../generated/app_localizations.dart';
import '../../../provider/events_provider.dart';

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
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.mainColor),
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            backgroundColor: AppColors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Icon(
                            Icons.my_location_rounded,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.chooseEventLocation,
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
                  SafeArea(
                    child: CustomMainButton(
                      text: AppLocalizations.of(context)!.save,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedTime != null && selectedDate != null) {
                            selectedDate = selectedDate!.copyWith(
                              hour: selectedTime!.hour,
                              minute: selectedTime!.minute,
                            );
                            EventModel eventModel = EventModel(
                              title: titleController.text,
                              date: DateFormat(
                                'yyyy-MM-dd hh:mm',
                              ).format(selectedDate!),
                              description: descriptionController.text,
                              isFav: false,
                              catId: selectedCategory.id,
                            );
                            try {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(50),
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).scaffoldBackgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      ),
                                    ),
                                barrierDismissible: false,
                              );
                              await Provider.of<EventProvider>(
                                context,
                                listen: false,
                              ).addEvent(eventModel);

                              Fluttertoast.showToast(
                                msg: 'Event added',
                                backgroundColor: Colors.green,
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: e.toString(),
                                backgroundColor: Colors.red,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Date and time required !',
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
