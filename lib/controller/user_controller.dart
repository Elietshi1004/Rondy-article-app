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

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription? mj;
  // var listPub = <Publier>[].obs;
  var mapListPub = <String, Publier>{}.obs;
  var user = model.User(
          bio: "",
          email: "",
          followers: [],
          following: [],
          id: "",
          nameUser: "",
          image: "")
      .obs;
  @override
  void onInit() {
    super.onInit();
    if (Setting.homeCtrl.getValueStorage("usersave") != null) {
      user.value =
          model.User.fromJson(Setting.homeCtrl.getValueStorage("usersave"));
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (mj != null) mj!.cancel();
  }

  Future<model.User> getUser(String uid) async {
    var res = await _firestore.collection("users").doc(uid).get();
    return model.User.fromSnap(res);
  }

  Future<bool> updateUser(model.User us) async {
    try {
      await _firestore.collection("users").doc(us.id).update(us.tojson());
      if (us.id.trim() == user.value.id.trim()) {
        Setting.homeCtrl.setValueStorage("usersave", us.tojson());
      }
      return true;
    } catch (e) {
      printDebug("error update user $e");
      return false;
    }
  }

  Future<bool> updateUserProfil(model.User us, String path) async {
    try {
      String imageUrl = await StorageMethod()
          .uploadImageToStorage('profile_user', File(path), false);
      await _firestore
          .collection("users")
          .doc(us.id)
          .update({"image": imageUrl});
      if (us.id.trim() == user.value.id.trim()) {
        us.image = imageUrl;
        Setting.homeCtrl.setValueStorage("usersave", us.tojson());
      }
      return true;
    } catch (e) {
      printDebug("error update user $e");
      return false;
    }
  }
}
