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
import '../../../provider/user_provider.dart';

class EditEventScreen extends StatefulWidget {
  EditEventScreen({super.key, required this.eventModel});

  static const routeName = '/newEvent';
  EventModel eventModel;

  late CategoryModel selectedCategory;
  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.eventModel.title.toString();
    descriptionController.text = widget.eventModel.description.toString();
    widget.selectedCategory =
        CategoryModel.categories
            .where((e) => e.id == widget.eventModel.catId)
            .first;
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.editEvent)),
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
                    selectedCategory: widget.selectedCategory,
                    onChanged: (category) {
                      setState(() {
                        widget.selectedCategory = category;
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
                        return 'description is required';
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
                      text: AppLocalizations.of(context)!.update,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            showDialog(
                              context: context,
                              builder: (context) => Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(50),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ],
                                ),
                              ),
                              barrierDismissible: false,
                            );

                            DateTime currentDateTime =
                            DateFormat('yyyy-MM-dd hh:mm').parse(widget.eventModel.date);

                            final newDate = selectedDate ?? currentDateTime;
                            final newTime = selectedTime ?? TimeOfDay.fromDateTime(currentDateTime);

                            final updatedDateTime = DateTime(
                              newDate.year,
                              newDate.month,
                              newDate.day,
                              newTime.hour,
                              newTime.minute,
                            );

                            widget.eventModel.date =
                                DateFormat('yyyy-MM-dd hh:mm').format(updatedDateTime);

                            await Provider.of<EventProvider>(
                              context,
                              listen: false,
                            ).editEvent(
                              event: widget.eventModel,
                              title: titleController.text,
                              description: descriptionController.text,
                              catId: widget.selectedCategory.id,
                            );

                            await Provider.of<UserProvider>(
                              context,
                              listen: false,
                            ).updateFavEvent(
                              event: widget.eventModel,
                              title: titleController.text,
                              description: descriptionController.text,
                              catId: widget.selectedCategory.id,
                            );

                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();

                            Fluttertoast.showToast(
                              msg: 'Event Updated',
                              backgroundColor: Colors.green,
                            );
                            setState(() {});
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: e.toString(),
                              backgroundColor: Colors.red,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Date and time required!',
                            backgroundColor: Colors.red,
                          );
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
      return widget.eventModel.date.split(' ').last;
    }
    return selectedTime!.format(context);
  }

  String _getDateText() {
    if (selectedDate == null) {
      return widget.eventModel.date.split(' ').first;
    }
    return DateFormat.yMEd().format(selectedDate!);
  }
}
