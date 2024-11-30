import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? id;
  String? email;

  UserModel({
    required this.id,
    required this.email,
  });

  factory UserModel.fromFirebaseUser(User? user) {
    return UserModel(
      id: user?.uid ?? '',
      email: user?.email ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}
