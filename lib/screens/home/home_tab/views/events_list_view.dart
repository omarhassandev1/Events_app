import 'package:evently_application/common/widgets/event_card.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../gen/assets.gen.dart';
import '../../../events/event_details/event_datails_screen.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:
          (context, value, child) => ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => EventDetailsScreen(eventModel: events[index]),
                    ),
                  );
                },
                child: EventCard(event: events[index]),
              );
            },
            itemCount: events.length,
          ),
    );
  }
}
