import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _style;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(31.1906176028795, 29.907885809610256),
        zoom: 12,
      ),
      style: _style,
      polylines: {
        Polyline(
          polylineId: PolylineId('1'),
          color: Colors.blueAccent,
          width: 5,
          points: [
            LatLng(30.0444, 31.2357),
            LatLng(30.1700, 30.9500),
            LatLng(30.5000, 30.3000),
            LatLng(30.8000, 30.0000),
            LatLng(31.0000, 29.8000),
            LatLng(31.2001, 29.9187),
          ],
        ),
      },
      markers: {
        Marker(
          markerId: MarkerId('1'),
          position: LatLng(31.1906176028795, 29.907885809610256),
        ),
      },
    );
  }

  Future<void> _loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map_style/style.json',
    );
    setState(() {
      _style = style;
    });
  }
}
