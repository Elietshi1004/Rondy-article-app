import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rondyarticleapp/controller/publier_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/home_controller.dart';
import 'controller/user_controller.dart';

void printDebug(Object? text) {
  if (kDebugMode) {
    print(text);
  }
}

//bloc plein : ca-app-pub-5219243523324651/1249693487
//avec recompense : ca-app-pub-5219243523324651/8745040125
class Setting {
  // static var db = new DatabaseHelper();
  // static String path = "https://www.sncdigi.com/alerte";
  // static String path = "http://app.congoprotect.com";
  static String path = "http://sos243.com";

  static bool son = true;
  static var listMode = ["1 joueur", "2 joueurs"];
  static var listSon = ["OUI", "NON"];
  static var listDiff = [
    "Très facile",
    "facile",
    "Difficile",
    "Très Difficile"
  ];
  static var listPlateau = ["Scène 1", "Scène 2", "Scène 3"];
  static var listCouleur = ["defaut", "rouge", "vert", "jaune", "blanc"];
  static var listGagner = [
    "aucun",
    "75 points",
    "100 points",
    "130 points",
    "160 points"
  ];
  // static UserModel userActual = UserModel();
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static FirebaseAuth? auth;
  static User? user;
  static Color mainColor = const Color(0xff292C31);
  static Color secondColor = const Color(0xffA9DED8);
  static bool isConnect = false;
  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Colors.blueGrey.shade800,
    Colors.black87,
    // secondColor,
    // mainColor
  ];

  // static late SharedPreferences prefs;
  static Directory? directory;
  static String version = "1.0";
  // static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // static CollectionReference fUser = firestore.collection("Users");
  // static final FirebaseDatabase dataCloud = FirebaseDatabase.instance;
  // static DatabaseReference fUser = Setting.dataCloud.reference().child("User");
  // static DatabaseReference fAlerte =
  //     Setting.dataCloud.reference().child("Alerte");
  // static DatabaseReference fToken =
  //     Setting.dataCloud.reference().child("TokenUser");

  static Future initUser() async {
    WidgetsFlutterBinding.ensureInitialized();
    print("On y esttttttttt1");
    await Firebase.initializeApp().whenComplete(() async {
      auth = FirebaseAuth.instance;
      user = auth!.currentUser;
    });
    await GetStorage.init();
    // initFolder();
    print("On y esttttttttt2");
  }

/* 
  static Future<String?> downloadFile(
      {String? filePath, required String url}) async {
    // CancelToken cancelToken = CancelToken();
    Dio dio = Dio();
    String? path = filePath;
    try {
      await dio.download(
        url,
        filePath,
        deleteOnError: true,
        onReceiveProgress: (count, total) {
          debugPrintDebug('---Download----Rec: $count, Total: $total');
          printDebug("ypoooooo");
          // setState(() {
          //   _platformVersion = ((count / total) * 100).toStringAsFixed(0) + "%";
          // });
        },
      );
    } catch (e) {
      path = "";
      printDebug(e.toString());
    }

    return path;
  } */

  // static EncryptionService cryptMessage = EncryptionService(encryptObject);

  static HomeController get homeCtrl {
    try {
      return Get.find<HomeController>();
    } catch (e) {
      return Get.put(HomeController());
    }
  }

  static PublierController get publierCtrl {
    try {
      return Get.find<PublierController>();
    } catch (e) {
      return Get.put(PublierController());
    }
  }

  static UserController get userCtrl {
    try {
      return Get.find<UserController>();
    } catch (e) {
      return Get.put(UserController());
    }
  }

  static Map<String, dynamic> getTime(int sec) {
    if (sec < 60) return {"time": sec, "day": "seconde"};
    if (sec > 60 && sec < 3600) {
      return {"time": sec / 60, "day": "minute"};
    } else if (sec > 3600 && sec < 86400) {
      return {"time": sec / 3600, "day": "heure"};
    } /*else if(sec>86400)
      return {
        "time" : sec/86400 as int,
        "day" : "jour"
      };*/
    else
      return {"time": sec, "day": "date"};
  }

  static String parseDate(String date) {
    DateTime? dt = DateTime.tryParse(date);
    if (dt == null) return "";
    String formatDt = "";
    if (dt.day < 10)
      formatDt += "0" + dt.day.toString();
    else
      formatDt += dt.day.toString();
    formatDt += "/";
    if (dt.month < 10)
      formatDt += "0" + dt.month.toString();
    else
      formatDt += dt.month.toString();
    formatDt += "/" + dt.year.toString();

    return formatDt;
  }

  static String parseDay(String date) {
    DateTime? dt = DateTime.tryParse(date);
    if (dt == null) return "";
    String formatDt = "";
    switch (dt.weekday) {
      case 1:
        formatDt = "Lundi";

        break;
      case 2:
        formatDt = "Mardi";

        break;
      case 3:
        formatDt = "Mercredi";

        break;
      case 4:
        formatDt = "Jeudi";

        break;
      case 5:
        formatDt = "Vendredi";

        break;
      case 6:
        formatDt = "Samedi";

        break;
      case 7:
        formatDt = "Dimanche";

        break;
      default:
    }
    formatDt += ", ";
    formatDt += dt.hour.toString();
    formatDt += ":";

    if (dt.minute < 10) {
      formatDt += "0";
    }
    formatDt += dt.minute.toString();
    return formatDt;
  }

  static String mailto = 'mailto:etappscontact@gmail.com'; //?subject=<subject>
  static String phoneto = 'tel:+243970913814';
  static String smsto = 'sms:+243821639042';
  static Future<bool> openUrl(String url, {bool newWindow = false}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      return await launchUrl(
        Uri.parse(url),
      );
    } else {
      printDebug("Could not launch $url");
      return false;
    }
  }
/* 
  static void showMessage(String title, String msg) {
    Get.snackbar(title, msg,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  static Future showDialog(String title, String msg) async {
    await Get.defaultDialog(
        title: title,
        middleText: msg,
        textCancel: "Ok",
        backgroundColor: mainColor,
        middleTextStyle: TextStyle(color: secondColor),
        titleStyle: TextStyle(color: secondColor));
  }

  static Future<bool> saveAllFileToDownload(
      {required String url,
      required String fileName,
      required Function(String? v1, double v2) onProgress,
      required Function(String v1) onComplete,
      required Function(String v1) onError}) async {
    var f = await FileDownloader.downloadFile(
        url: url,
        name: fileName,
        onProgress: onProgress,
        onDownloadCompleted: onComplete,
        onDownloadError: onError);
    if (f == null) return false;
    return true;
  }

  static Future<bool> saveAllFile(
      String url, String fileName, Function(int v1, int v2) onProgress) async {
    final Dio dio = Dio();
    // Directory? directory;
    try {
      if (Platform.isAndroid) {
        bool test = true;
        try {
          var androidInfo = await DeviceInfoPlugin().androidInfo;
          var release = androidInfo.version.release;
          var sdkInt = androidInfo.version.sdkInt;
          var manufacturer = androidInfo.manufacturer;
          var model = androidInfo.model;
          printDebug("version $release $sdkInt");
          if ((sdkInt ?? 0) >= 30) {
            test = await _requestPermission(Permission.manageExternalStorage);
          }
        } catch (er) {
          printDebug("erreur permission $er");
        }
        if (await _requestPermission(Permission.storage) && test) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          printDebug(directory.toString());
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/ShareToMe";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory!.path}/$fileName");
      if (!await directory!.exists()) {
        await directory!.create(recursive: true);
      }
      if (await directory!.exists()) {
        await dio.download(url, saveFile.path, onReceiveProgress: onProgress);
        if (Platform.isIOS) {
          // await ImageGallerySaver.saveFile(saveFile.path,
          //     isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      printDebug("error downoad $e");
      return false;
    }
  }

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  } */
}



/*

class Minimax {
  int bestMove(GameState state) {
    // Initialise la meilleure valeur à -infini et la meilleure action à -1
    int bestValue = -double.infinity, bestAction = -1;

    // Pour chaque action possible
    for (int action in state.possibleActions()) {
      // Applique l'action et obtient l'état suivant
      GameState nextState = state.applyAction(action);
      
      // Appelle la fonction de valeur pour obtenir la valeur de l'état suivant
      int value = minValue(nextState);

      // Si la valeur de l'état suivant est meilleure que la meilleure valeur actuelle
      if (value > bestValue) {
        // Met à jour la meilleure valeur et la meilleure action
        bestValue = value;
        bestAction = action;
      }
    }

    // Retourne la meilleure action
    return bestAction;
  }

  int maxValue(GameState state) {
    // Si l'état est final, retourne la valeur de l'état
    if (state.isFinal()) {
      return state.value();
    }

    // Initialise la meilleure valeur à -infini
    int bestValue = -double.infinity;

    // Pour chaque action possible
    for (int action in state.possibleActions()) {
      // Applique l'action et obtient l'état suivant
      GameState nextState = state.applyAction(action);

      // Appelle la fonction de valeur pour obtenir la valeur de l'état suivant
      int value = minValue(nextState);

      // Met à jour la meilleure valeur si nécessaire
      bestValue = max(bestValue, value);
    }

    // Retourne la meilleure valeur
    return bestValue;
  }

  int minValue(GameState state) {
    // Si l'état est final, retourne la valeur de l'état
    if (state.isFinal()) {
      return state.value();
    }

    // Initialise la meilleure valeur à +infini
    int bestValue = double.infinity;

    // Pour chaque action possible
    for (int action in state.possibleActions()) {
      // Applique l'action et obtient l'état suivant
      GameState nextState = state.applyAction(action);

      // Appelle la fonction de valeur pour obtenir la valeur de l'état suivant
      int value = maxValue(nextState);

      // Met à jour la meilleure valeur si nécessaire
      bestValue = min(bestValue, value);
    }

    // Retourne la meilleure valeur


*/