import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Publier {
  String id;
  String titre;
  String contentJson;
  String contenu;
  String image;
  DateTime? dt;

  Publier(
      {required this.id,
      required this.titre,
      required this.contentJson,
      required this.contenu,
      required this.image,
      this.dt});

  static Publier fromjson(Map<String, dynamic> json) {
    return Publier(
        id: json["id"],
        titre: json["titre"],
        contentJson: json["contentJson"],
        contenu: json["contenu"],
        dt: json["date"] != null
            ? json["date"] is String
                ? DateTime.tryParse(json["date"].toString())
                : DateTime.fromMillisecondsSinceEpoch(
                    json["date"].millisecondsSinceEpoch)
            : null,
        image: json["image"]);
  }

  Map<String, dynamic> tojson() => {
        'id': id,
        'titre': titre,
        'contentJson': contentJson,
        'contenu': contenu,
        'image': image,
        "date": FieldValue.serverTimestamp()
      };
}
