import 'package:evently_application/provider/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app_colors.dart';

class EventMap extends StatefulWidget {
  final EventModel eventModel;

  const EventMap({super.key, required this.eventModel});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  String? _style;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    final LatLng eventPosition = LatLng(
      widget.eventModel.latitude,
      widget.eventModel.longitude,
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.eventModel.title)),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: eventPosition,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('event_location'),
                position: eventPosition,
                infoWindow: InfoWindow(title: widget.eventModel.title),
              ),
            },
            style: _style,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.eventModel.locationName,
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
