import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/network/events_services.dart';
import 'package:flutter/cupertino.dart';

class EventProvider extends ChangeNotifier {
  List<EventModel> eventsList = [];
  String? errorMessage;
  bool isLoading = false;
  int selectedCatId = 1;

  Future<void> getEvents() async {
    isLoading = true;
    notifyListeners();
    try {
      eventsList = await EventServices.getAllEvents();
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getFilteredEvents() async {
    isLoading = true;
    notifyListeners();
    try {
      eventsList = await EventServices.getFilteredEvents(selectedCatId);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  editSelectedId(int catId) async {
    if (catId == selectedCatId) return;
    selectedCatId = catId;
    notifyListeners();
    if (selectedCatId == 1) {
      await getEvents();
      return;
    } else {
      await getFilteredEvents();
    }
  }

  Future<void> addEvent(EventModel newEvent) async {
    try {
      await EventServices.createNewEvent(newEvent);
      eventsList.add(newEvent);
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeEvent(EventModel event) async {
    try {
      await EventServices.deleteEvent(event);
      getEvents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> editEvent({
    required EventModel event,
    String? title,
    String? description,
    String? date,
    int? catId,
  }) async {
    try {
      EventServices.editEvent(
        event: event,
        title: title,
        description: description,
        date: date,
        catId: catId,
      );
      getEvents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
