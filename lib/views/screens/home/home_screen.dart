import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Setting.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/constants/constants.dart';
import '../../base/textField/CustomIcon.dart';
import '../../profil/profil_screen.dart';
import '../myarticle/mya.dart';
import '../publier/open_screen.dart';
import '../search/search_screen.dart';
import 'accueilScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  PageController controller = PageController();
  var menuItems = <String>[
    "Deconnexion",
    "A propos",
  ];
  late final List<PopupMenuItem<String>> _popUpMenuItems;
  @override
  void initState() {
    super.initState();
    _popUpMenuItems = menuItems
        .map((String value) => PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ))
        .toList();
  }

  void singOutUser() async {
    // setState(() {
    //   isLoading = true;
    // });
    String res = await AuthController().singOut();
    if (res == "success") {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 1.1, spreadRadius: 0.7)
                  ]),
              child: const Center(
                  child: Text(
                "MA",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))),
        ),
        title: const Text("Articles Publiées"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.update,
                color: Colors.black,
              )),
          PopupMenuButton<String>(
            color: Colors.black,
            onSelected: (value) {
              if (value.contains("n")) {
                Get.defaultDialog(
                    title: "Deconnexion",
                    middleText: "Vous voulez vraiment vous deconnecter?",
                    textCancel: "Annuler",
                    textConfirm: "Oui",
                    onCancel: () {},
                    // backgroundColor: Setting.mainColor,
                    // titleStyle: TextStyle(color: Setting.secondColor),
                    // middleTextStyle: TextStyle(color: Setting.secondColor),
                    onConfirm: () {
                      Get.back();
                      singOutUser();
                    });
              } else {
                Get.defaultDialog(
                    title: "A propos",
                    middleText:
                        "Cette application n'est pas une version complète du projet et il est réalisé dans le cadre d'un travail pratique du cours de Génie logiciel dispensé en L2 informatique de la faculté de Science de l'Université de Kinshasa\n"
                        "ETUDIANT AYANT PARTICIPE :\n"
                        "KAFUMU MBUTI RONDY\n"
                        "NKEMBI LUNGELA ABIGAEL\n"
                        "BAKUMBA SAMAIN");
              }
            },
            itemBuilder: (BuildContext context) => _popUpMenuItems,
          ),
        ],
      ),
      body: PageView(
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
          controller: controller,
          children: [
            AccueilUI(),
            SearchScreen(),
            OpenScreen(),
            MyArticleUI(),
            ProfilUI(),
            // MyProfileScreen(),
          ]),
      //  listMenu[pageIndex]
      // Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white.withOpacity(0.0),
        elevation: 0.0,
        unselectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
          controller.jumpToPage(pageIndex);
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 30), label: "Recherche"),
          BottomNavigationBarItem(icon: Center(child: CustomIcon()), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.publish, size: 30), label: "Mes articles"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 30), label: "Profile"),
        ],
      ),
    );
  }
}
