import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_main_button.dart';
import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/screens/new_event/views/category_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/custom_text_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Padding(
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
                label: 'Title',
                hintText: 'Event title',
                prefixIcon: Icon(Icons.edit_outlined),
              ),
              CustomTextField(
                label: 'Title',
                hintText: 'Event title',
                maxLines: 5,
              ),
              Column(
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                      Text(
                        "Event Date",
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
                        color: Theme.of(context).textTheme.titleMedium!.color,
                      ),
                      Text(
                        "Event Time",
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
                      'Choose Event Location',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.mainColor),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded,color: AppColors.mainColor,)
                  ],
                ),
              ),
              SafeArea(child: CustomMainButton(text: 'Save', onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeText() {
    if (selectedTime == null) {
      return 'Select TIme';
    }
    return selectedTime!.format(context);
  }

  String _getDateText() {
    if (selectedDate == null) {
      return 'Select Date';
    }
    return DateFormat.yMEd().format(selectedDate!);
  }
}
