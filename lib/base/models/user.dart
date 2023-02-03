import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class User {
  String nameUser;
  String email;
  String id;
  String bio;
  List followers;
  List following;
  String? image;

  User(
      {required this.nameUser,
      required this.email,
      required this.id,
      required this.bio,
      required this.followers,
      required this.following,
      this.image});

  Map<String, dynamic> tojson() => {
        "nameUser": nameUser,
        'email': email,
        'id': id,
        'bio': bio,
        'followers': followers,
        'following': following,
        'image': image
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return User(
        nameUser: snapShot['nameUser'],
        email: snapShot["email"],
        id: snapShot['id'],
        bio: snapShot['bio'],
        followers: snapShot['followers'],
        following: snapShot['following'],
        image: snapShot['image']);
  }

  static User fromJson(Map<String, dynamic> snapShot) {
    // var snapShot = snap.data() as Map<String, dynamic>;

    return User(
        nameUser: snapShot['nameUser'],
        email: snapShot["email"],
        id: snapShot['id'],
        bio: snapShot['bio'],
        followers: snapShot['followers'],
        following: snapShot['following'],
        image: snapShot['image']);
  }
}
