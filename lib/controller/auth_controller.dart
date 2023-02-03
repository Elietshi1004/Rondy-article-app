import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rondyarticleapp/Setting.dart';
import 'package:rondyarticleapp/base/models/user.dart' as model;
import 'package:rondyarticleapp/controller/storage_method.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> singUser(
      {required String nameUser,
      required String email,
      required String bio,
      required String password,
      required File? file}) async {
    String res = "Some error occurred";

    try {
      // ignore: unnecessary_null_comparison
      if (nameUser.isNotEmpty ||
          email.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        //registed user
        UserCredential cred = await Setting.auth!
            .createUserWithEmailAndPassword(email: email, password: password);
        // ignore: avoid_print
        print(cred.user!.uid);
        String profilUrl = file == null
            ? ""
            : await StorageMethod()
                .uploadImageToStorage('profile_user', file, false);

        //add user to our database
        model.User user = model.User(
            nameUser: nameUser,
            email: email,
            id: cred.user!.uid,
            bio: bio,
            followers: [],
            following: [],
            image: profilUrl);
        _firestore.collection("users").doc(cred.user!.uid).set(user.tojson());
        Setting.homeCtrl.setValueStorage("usersave", user.tojson());
        Setting.userCtrl.user.value = user;
        Setting.user = cred.user;
        /*
        _firestore.collection("publication").doc(cred.user!.uid).set({
          'username':nameUser,
          'uid':cred.user!.uid,
          'titre':[],
          'image':[],
          'description': [],
          
        });*/
        /*
        _firestore.collection("users").doc(cred.user!.uid).add({
          'username':nameUser,
          'uid':cred.user!.uid,
          'bio':bio,
          'article':[],
        });
         */
        res = "success";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User found for thant email");
      } else if (e.code == 'wrong-password') {
        print("wrong password provider for thant User");
      }

      res = e.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res;

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        var cred = await Setting.auth!
            .signInWithEmailAndPassword(email: email, password: password);
        var us = await Setting.userCtrl.getUser(cred.user!.uid);
        Setting.user = cred.user;
        Setting.homeCtrl.setValueStorage("usersave", us.tojson());
        Setting.userCtrl.user.value = us;
        res = "success";
      } else {
        res = "Please enter all fields";
      }
    } catch (err) {
      res = err.toString();
    }
    printDebug("res result $res");
    return res;
  }

  //login anomyme
  Future<String> loginAnomyme() async {
    String res;

    try {
      await _auth.signInAnonymously();
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> singOut() async {
    String res;
    try {
      await FirebaseAuth.instance.signOut();
      Setting.homeCtrl.eraseStorage();
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
