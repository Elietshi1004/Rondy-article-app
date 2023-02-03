/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
  */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'package:get/get.dart';

import '../../../Setting.dart';
import '../../../base/models/publication.dart';

import 'package:rondyarticleapp/base/models/user.dart' as model;

import '../../profil/profil_screen.dart';

class ArticleUI extends StatefulWidget {
  const ArticleUI({super.key, required this.publier});
  final Publier publier;
  @override
  State<ArticleUI> createState() => _ArticleUIState();
}

class _ArticleUIState extends State<ArticleUI> {
  late fq.QuillController controller;
  @override
  void initState() {
    super.initState();
    var myJSON = jsonDecode(widget.publier.contentJson);

    controller = fq.QuillController(
      document: fq.Document.fromJson(myJSON),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String image = images[1];
    var pub = widget.publier;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('Detail Article'),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.share),
          //   onPressed: () {},
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                  height: 300,
                  width: double.infinity,
                  child: pub.image.isEmpty
                      ? Image.asset("assets/svg/female-investors.gif")
                      : Image.network(
                          pub.image,
                          fit: BoxFit.cover,
                        )),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 250.0, 16.0, 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      pub.titre,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                        "${Setting.parseDay(pub.dt == null ? "" : pub.dt.toString())} ${Setting.parseDate(pub.dt == null ? "" : pub.dt.toString())}"),
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FutureBuilder<model.User>(
                        future: Setting.userCtrl.getUser(pub.id),
                        builder: (ct, sn) {
                          if (sn.hasData) {
                            return ListTile(
                              onTap: () {
                                Get.to(ProfilUI(
                                  user: sn.data,
                                ));
                              },
                              leading: CircleAvatar(
                                radius: 20,
                                child: sn.data!.image == null ||
                                        sn.data!.image!.isEmpty
                                    ? Image.asset("assets/svg/male-avatar.gif")
                                    : ClipOval(
                                        child: Image.network(
                                          sn.data!.image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              title: Text(sn.data!.nameUser),
                              subtitle: Text(sn.data!.bio),
                            );
                          } else {
                            return const Text("Loading...");
                          }
                        }),
                    SizedBox(
                      height: 600,
                      child: Column(
                        children: [
                          // Text(
                          //   pub.titre,
                          //   style: const TextStyle(
                          //       fontSize: 15, color: Colors.grey),
                          //   textAlign: TextAlign.center,
                          // ),
                          // const SizedBox(height: 30),
                          Flexible(
                            child: Container(
                              height: 400,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              // margin: const EdgeInsets.symmetric(
                              //     horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: fq.QuillEditor.basic(
                                controller: controller,
                                readOnly: true, // true for view only mode
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
