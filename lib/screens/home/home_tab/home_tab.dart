import 'package:evently_application/common/widgets/custom_main_button.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/screens/home/home_tab/views/events_list_view.dart';
import 'package:evently_application/screens/home/home_tab/views/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventProvider>(context, listen: false).getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            const HomeHeader(),
            if (value.isLoading)
              const Expanded(
                  child: Center(child: CircularProgressIndicator()))
            else if (value.errorMessage != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(value.errorMessage!),
                      CustomMainButton(
                        text: 'Reload',
                        onPressed: () {
                          value.getEvents();
                        },
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(child: EventsListView(events: value.eventsList)),
          ],
        );
      },
    );
  }
}
