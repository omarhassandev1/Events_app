import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('${userCredential.user?.uid}');
      return await _getUSerInfo(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print('||||||||| Error ----> ${e.message}');
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
          toFirestore: (value, options) => value.tojson(),
        );
    return users;
  }

  static _addUSer(UserModel user) async {
    CollectionReference<UserModel> userCollection =
        _getUsersCollection(); // got the collection
    DocumentReference doc = userCollection.doc(user.uid); // got the document
    await doc.set(user); // set the values
  }

  static Future<UserModel?> _getUSerInfo(String uid) async {
    CollectionReference<UserModel> userCollection =
        _getUsersCollection(); // got the collection
    DocumentReference<UserModel> doc = userCollection.doc(uid);
    DocumentSnapshot<UserModel> snapshot = await doc.get();
    return snapshot.data();
  }
}
