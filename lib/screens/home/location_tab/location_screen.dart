import 'package:evently_application/models/category_model.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../gen/assets.gen.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).eventsList;

    Set<Marker> markers = events.map((event) {
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
          });
        },
      );
    }).toSet();

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: events.isNotEmpty
                ? LatLng(events[0].latitude, events[0].longitude)
                : const LatLng(30.0444, 31.2357),
            zoom: 12,
          ),
          markers: markers,
          onMapCreated: (controller) => _mapController = controller,
        ),
        SizedBox(
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
                    _selectedLatLng =
                        LatLng(event.latitude, event.longitude);
                  });
                },
                child: EventLocationCard(event: event),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EventLocationCard extends StatelessWidget {
  const EventLocationCard({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  Widget build(BuildContext context) {

    int catId = event.catId;
    CategoryModel category = CategoryModel.categories.where((e)=>e.id==catId).first;
    category.image;
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mainColor),
      ),
      child: Row(
        children: [
          Expanded(child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(category.image!))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Assets.svg.locationOutlined.svg(),
                    Expanded(
                      child: Text(
                        event.locationName,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
