class UserModel {
  String name;
  String email;
  String? uid;
  UserModel({required this.email, required this.name, this.uid});

  Map<String, dynamic> tojson() {
    return {'name': name, 'uid': uid, 'email': email};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
    );
  }
}
