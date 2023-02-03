import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rondyarticleapp/Setting.dart';
import 'package:rondyarticleapp/views/screens/publier/detail_pub.dart';

import '../../../base/models/publication.dart';
import '../../../base/models/user.dart' as model;

/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'package:flutter/material.dart';

import '../../base/tilehome.dart';
import '../home/detail.dart';

class MyArticleUI extends StatefulWidget {
  static final String path = "lib/src/pages/blog/sports_news1.dart";

  const MyArticleUI({super.key});

  @override
  State<MyArticleUI> createState() => _MyArticleUIState();
}

class _MyArticleUIState extends State<MyArticleUI> {
  final Color bgColor = const Color(0xffF3F3F3);
  final Color primaryColor = const Color(0xffE70F0B);
  PageController controller = PageController();
  var titleTextStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  var teamNameTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade800,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var list = Setting.publierCtrl.mapListPub.values.toList();
    // var dn = DateTime.now();
    var listPubMe =
        list.where((e) => e.id.trim() == Setting.user!.uid).toList();
    listPubMe.sort((a, b) {
      return b.dt.toString().compareTo(a.dt.toString());
    });

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            "Mes Articles",
            style: TextStyle(color: Colors.black, fontSize: 30.0),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     color: Colors.black,
          //     icon: Icon(Icons.search),
          //     onPressed: () {},
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Les Articles Recents",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                    itemCount: listPubMe.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          getLineArticle(listPubMe[index]),
                          const Divider()
                        ],
                      );
                    }),
              )
            ],
          ),
        ));
  }

  Widget getCardArticle(Publier publier) {
    return InkWell(
      onTap: () {
        Get.to(ArticleUI(
          publier: publier,
        ));
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                        image: (publier.image.isNotEmpty
                                ? NetworkImage(publier.image)
                                : const AssetImage(
                                    "assets/gif/man-holding-note.gif"))
                            as ImageProvider,
                        fit: BoxFit.cover,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    publier.titre,
                    style: titleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                          "${Setting.parseDay(publier.dt == null ? "" : publier.dt.toString())} ${Setting.parseDate(publier.dt == null ? "" : publier.dt.toString())}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                          )),
                      // Spacer(),
                      // Text(
                      //   "Football",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 14.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
            Positioned(
              top: 190,
              left: 20.0,
              child: Container(
                color: Colors.green,
                padding: const EdgeInsets.all(4.0),
                child: const Text(
                  "TODAY",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccueilScreen extends StatefulWidget {
  const AccueilScreen({super.key});

  @override
  State<AccueilScreen> createState() => _AccueilScreenState();
}

class _AccueilScreenState extends State<AccueilScreen> {
  String userName = "";
  late StreamSubscription mj;
  @override
  void initState() {
    // getUserName();
    super.initState();
    mj = Setting.publierCtrl.mapListPub.listen((p0) {
      if (mounted) setState(() {});
    });
  }

  void getUserName() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    printDebug(snap.data());
    setState(() {
      userName = (snap.data() as Map<String, dynamic>)['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Les Articles du jour",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 400,
            width: size.width,
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/svg/female-investors.gif",
                          height: 300,
                          width: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        "Titre de l'article",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 51, 50, 50)),
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Les Articles Recents",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        // ignore: sort_child_properties_last
                        child: Image.asset(
                          "assets/svg/female-investors.gif",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    ));
  }
}
