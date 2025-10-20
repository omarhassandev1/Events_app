import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_application/models/event_model.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return await getUSerInfo();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Something went wrong";
    }
    return null;
  }

  static register(UserModel user, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      String uid = userCredential.user!.uid;
      user.uid = uid;
      await _addUSer(user);
    } on FirebaseAuthException catch (e) {
      print('||||||||| Error ----> ${e.message}');
      throw e.message ?? "Something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  static _getUsersCollection() {
    CollectionReference users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore:
              (snapshot, options) => UserModel.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        );
    return users;
  }

  static _addUSer(UserModel user) async {
    CollectionReference<UserModel> userCollection =
        _getUsersCollection(); // got the collection
    DocumentReference doc = userCollection.doc(user.uid); // got the document
    await doc.set(user); // set the values
  }

  static Future<UserModel?> getUSerInfo() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return null;
    }
    CollectionReference<UserModel> userCollection = _getUsersCollection();
    DocumentReference<UserModel> doc = userCollection.doc(uid);
    DocumentSnapshot<UserModel> snapshot = await doc.get();
    UserModel? user = snapshot.data();
    if (user != null) {
      user.favEvents = await getFavEvents();
      return user;
    }
    return null;
  }

  static CollectionReference<EventModel> getUserFavEventsCollection() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference<UserModel> userCollection = _getUsersCollection();
    CollectionReference<EventModel> eventsCollection = userCollection
        .doc(uid)
        .collection('fav_events')
        .withConverter<EventModel>(
          fromFirestore:
              (snapshot, options) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return eventsCollection;
  }

  static Future<List<EventModel>> getFavEvents() async {
    CollectionReference<EventModel> collection = getUserFavEventsCollection();
    QuerySnapshot<EventModel> snapshot = await collection.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static addFavEvent(EventModel event) async {
    CollectionReference<EventModel> collection = getUserFavEventsCollection();
    DocumentReference<EventModel> doc = collection.doc(event.id);
    await doc.set(event);
  }

  static void removeFavEvent(String id) async {
    CollectionReference<EventModel> collection = getUserFavEventsCollection();
    await collection.doc(id).delete();
  }

  static Future<void> updateFavEvent({
    required EventModel event,
    String? title,
    String? description,
    String? date,
    int? catId,
  }) async {
    CollectionReference<EventModel> collection = getUserFavEventsCollection();
    collection.doc(event.id).update({
      'title': title ?? event.title,
      'description': description ?? event.description,
      'date': date ?? event.date,
      'catId': catId ?? event.catId,
    });
  }
}
