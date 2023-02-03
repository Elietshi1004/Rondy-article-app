import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Setting.dart';

// import 'package:lagetasite/model/HomeModel.dart';
// import 'package:lagetasite/model/agentModel.dart';
// import 'package:lagetasite/model/HomeModel.dart';

class HomeController extends GetxController {
  // late BannerAd ad;
  var isLoaded = false.obs;
  var isConnect = false.obs;
  StreamSubscription? con;
  double lat = 0, long = 0;
  // late Timer timer;
  bool on = false;
  // late StreamSubscription appBlock;

  // late StreamSubscription appAjour;
  var isAjour = true.obs;
  var isBlock = false.obs;
  var source = "".obs;
  StreamSubscription? mj;
  var listValueJ1 = <int>[]; //les valeurs prises à l'autre
  var listValueJ2 = <int>[];
  @override
  void onInit() {
    super.onInit();
    // timer = Timer.periodic(const Duration(seconds: 3), (t) async {
    //   printDebug("enteringg locationnnnnnn");
    //   if (on) return;
    //   on = true;
    //   printDebug("On locationnnnnnnnnnnnn");
    //   await posPermission();
    //   on = false;
    //   printDebug("location founddddd");
    // });

    printDebug("home controller is here");
  }

  @override
  void onClose() {
    super.onClose();
    // timer.cancel();
    con?.cancel();
    // appAjour.cancel();
    // appBlock.cancel();
  }

  setOptions(Map map) {
    var storage = GetStorage();
    storage.write("options", map);
  }

  setValueStorage(String key, dynamic value) {
    var storage = GetStorage();
    storage.write(key, value);
  }

  dynamic getValueStorage(String key) {
    var storage = GetStorage();

    return storage.read(key);
  }

  dynamic eraseStorage() {
    var storage = GetStorage();

    return storage.remove("usersave");
  }

  ///m pour mode, d pour difficulté, p pour plateau, c pour couleur et g pour gagner
  Map getOptions() {
    var storage = GetStorage();
    return storage.read("options") ?? {};
  }

  // Future<bool> posPermission() async {
  //   var permissions = await Permission.location.status;
  //   if (!permissions.isGranted) {
  //     permissions = await Permission.location.request();
  //   }

  //   if (permissions.isGranted) {
  //     await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.best)
  //         .then((value) {
  //       lat = value.latitude;
  //       long = value.longitude;
  //     });
  //   }
  //   return permissions.isGranted;
  // }
}
