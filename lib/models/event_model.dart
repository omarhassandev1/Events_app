import 'package:evently_application/models/user_model.dart';

class EventModel {
  String? id;
  String title;
  String date;
  String description;
  bool isFav;
  int catId;
  double latitude;
  double longitude;
  String locationName;

  EventModel({
    this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.isFav,
    required this.catId,
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'description': description,
      'isFav': isFav,
      'catId': catId,
      'latitude': latitude,
      'longitude': longitude,
      'locationName': locationName,
    };
  }

  static EventModel fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id']??'',
      title: json['title']??'',
      date: json['date']??'',
      description: json['description']??'',
      isFav: json['isFav']??'',
      catId: json['catId']??'',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      locationName: json['locationName']??'',
    );
  }
}
