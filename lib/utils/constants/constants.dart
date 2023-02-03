import 'package:flutter/material.dart';

import '../../views/profil/profil_screen.dart';
import '../../views/screens/home/accueilScreen.dart';
import '../../views/screens/publier/open_screen.dart';
import '../../views/screens/search/search_screen.dart';

const List listMenu = [
  AccueilScreen(),
  SearchScreen(),
  OpenScreen(),
  Text("add"),
  ProfileScreen(),
];

showSnakBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}
