import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String fullname;
  final String username;
  final String phone;

  UserModel({
    required this.id,
    required this.email,
    required this.fullname,
    required this.username,
    required this.phone,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      fullname: data['fullname'],
      username: data['username'],
      phone: data['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'fullname': fullname,
      'username': username,
      'phone': phone,
    };
  }
}
