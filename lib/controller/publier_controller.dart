import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rondyarticleapp/Setting.dart';
import 'package:rondyarticleapp/base/models/publication.dart';
import 'package:rondyarticleapp/base/models/user.dart' as model;

import 'package:rondyarticleapp/controller/storage_method.dart';

class PublierController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var pub =
      Publier(id: "", titre: "", contenu: "", image: "", contentJson: '').obs;
  StreamSubscription? mj;
  // var listPub = <Publier>[].obs;
  var mapListPub = <String, Publier>{}.obs;
  @override
  void onInit() {
    super.onInit();
    mj = _firestore.collection("article").snapshots().listen((event) {
      for (var el in event.docs) {
        var p = Publier.fromjson(el.data());
        mapListPub[el.reference.id] = p;
      }
      mapListPub.refresh();
      // listPub.clear();
      // listPub.addAll(event.docs.map((e) => Publier.fromjson(e.data())));
    });
  }

  @override
  void onClose() {
    super.onClose();
    if (mj != null) mj!.cancel();
  }

  Future<String> addArticle() async {
    String res = "some error occurred";

    try {
      String imageUrl = pub.value.image.isEmpty
          ? ""
          : await StorageMethod().uploadImageToStorage(
              'image_article', File(pub.value.image), true);
      Publier publier = Publier(
          id: Setting.user!.uid,
          contentJson: pub.value.contentJson,
          contenu: pub.value.contenu,
          titre: pub.value.titre,
          image: imageUrl);
      _firestore.collection("article").add(publier.tojson());
      res = "success";
    } catch (e) {
      printDebug(e);
    }
    return res;
  }
}
