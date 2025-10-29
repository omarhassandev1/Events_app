import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/screens/home/location_tab/widgets/event_location_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;
  int selectedCardIndex = -1;
  int selectedMarkerIndex = -1;
  Location location = Location();
  LatLng? initialLocation;

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).eventsList;

    Set<Marker> markers =
        events.map((event) {
          return Marker(
            markerId: MarkerId(event.title),
            position: LatLng(event.latitude, event.longitude),
            infoWindow: InfoWindow(
              title: event.title,
              snippet: event.locationName,
            ),

            onTap: () {
              setState(() {
                _selectedLatLng = LatLng(event.latitude, event.longitude);
                selectedCardIndex = events.indexOf(event);
                selectedMarkerIndex = events.indexOf(event);
              });
            },
          );
        }).toSet();

    return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target: initialLocation ?? const LatLng(30.0444, 31.2357),
                zoom: 12,
              ),
              markers: markers,
              onMapCreated: (controller) => _mapController = controller,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        initializeMap();
                      },
                      backgroundColor: AppColors.mainColor,
                      child: Icon(
                        Icons.gps_fixed_rounded,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return GestureDetector(
                          onTap: () {
                            _mapController?.animateCamera(
                              CameraUpdate.newLatLng(
                                LatLng(event.latitude, event.longitude),
                              ),
                            );
                            setState(() {
                              _selectedLatLng = LatLng(
                                event.latitude,
                                event.longitude,
                              );
                              selectedCardIndex = index;
                              selectedMarkerIndex = index;
                            });
                          },
                          child: EventLocationCard(
                            event: event,
                            isSelected: selectedCardIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
  }

  Future<void> initializeMap() async {
    // 1) checks if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        //error dialog
        return;
      }
    }
    // 2) check permission status
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        //error dialog
      }
    }

    // 3) get user location
    LocationData locationData = await location.getLocation();
    initialLocation = LatLng(locationData.latitude!, locationData.longitude!);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(initialLocation!, 14),
    );
  }
}
