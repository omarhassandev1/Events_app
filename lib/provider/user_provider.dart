import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:flutter/material.dart';

import '../models/event_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;
  bool isLoading = false;
  String? errorMessage;

  setUser(UserModel user) {
    isLoading = true;
    userModel = user;
    notifyListeners();
    isLoading = false;
  }

  removeFavEvent(String id) async {
    isLoading = true;
    AuthService.removeFavEvent(id);
    userModel = await AuthService.getUSerInfo();
    notifyListeners();
    isLoading = false;
  }

  getFavEvents() async {
    isLoading = true;
    try {
      if (userModel != null) {
        userModel!.favEvents = await AuthService.getFavEvents();
        notifyListeners();
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
  }

  Future<void> updateFavEvent({
    required EventModel event,
    String? title,
    String? description,
    String? date,
    int? catId,
  }) async {
    try {
      AuthService.updateFavEvent(
        event: event,
        title: title,
        description: description,
        date: date,
        catId: catId,
      );
      getFavEvents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
