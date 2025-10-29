import 'package:evently_application/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

import '../../../provider/settings_provider.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  LatLng? _pickedLocation;
  String? _locationName;
  String? _style;

  Future<void> _selectLocation(LatLng position) async {
    setState(() {
      _pickedLocation = position;
      _locationName = "Loading...";
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _locationName =
              "${place.locality ?? place.subAdministrativeArea ?? ''}, ${place.country ?? ''}";
        });
      } else {
        setState(() {
          _locationName = "Unknown location";
        });
      }
    } catch (e) {
      setState(() {
        _locationName = "Unknown location";
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Event Location')),
      body: Stack(
        children: [
          GoogleMap(
            style: _style,
            initialCameraPosition: const CameraPosition(
              target: LatLng(30.0444, 31.2357),
              zoom: 15,
            ),
            onTap: _selectLocation,
            markers:
                _pickedLocation == null
                    ? {}
                    : {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: _pickedLocation!,
                      ),
                    },
            zoomControlsEnabled: true,
          ),

          if (_pickedLocation != null)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_locationName != null)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _locationName!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16,color: AppColors.mainColor),
                        ),
                      ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (_pickedLocation != null) {
                          Navigator.pop(context, {
                            'lat': _pickedLocation!.latitude,
                            'lng': _pickedLocation!.longitude,
                            'name': _locationName ?? 'Unknown location',
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Select This Location',
                          style: TextStyle(color: Colors.white, fontSize: 16),
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
