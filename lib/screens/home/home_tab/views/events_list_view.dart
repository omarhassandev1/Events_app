import 'package:evently_application/common/widgets/event_card.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, required this.events});

  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return EventCard(event: events[index],);
        },
        itemCount: events.length,
      ),
    );
  }
}
