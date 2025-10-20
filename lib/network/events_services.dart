import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_application/models/event_model.dart';

class EventServices {
  static CollectionReference<EventModel> _getEventsCollection() {
    CollectionReference<EventModel> collection = FirebaseFirestore.instance
        .collection('events')
        .withConverter<EventModel>(
          fromFirestore:
              (snapshot, data) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return collection;
  }

  static Future<void> createNewEvent(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    DocumentReference<EventModel> doc = collection.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<EventModel>> getAllEvents() async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection.get();
    List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<List<EventModel>> getFilteredEvents(int catId) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    QuerySnapshot<EventModel> snapshot =
        await collection.where('catId', isEqualTo: catId).get();
    List<EventModel> events = snapshot.docs.map((e) => e.data()).toList();
    return events;
  }

  static Future<void> deleteEvent(EventModel event) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    collection.doc(event.id).delete();
  }

  static Future<void> editEvent({
    required EventModel event,

    String? title,
    String? description,
    String? date,
    int? catId,
  }) async {
    CollectionReference<EventModel> collection = _getEventsCollection();
    collection.doc(event.id).update({
      'title': title ?? event.title,
      'description': description ?? event.description,
      'date': date ?? event.date,
      'catId': catId ?? event.catId,
    });
  }
}
