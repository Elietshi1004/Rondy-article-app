import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:rondyarticleapp/Setting.dart';

import 'detail_pub.dart';

class PublicationScreen extends StatefulWidget {
  const PublicationScreen({
    super.key,
    required this.titre,
    required this.image,
  });
  final String titre;
  final String image;
  @override
  State<PublicationScreen> createState() => _PublicationScreenState();
}

class _PublicationScreenState extends State<PublicationScreen> {
  QuillController controller = QuillController.basic();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white.withOpacity(0.0),
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(left: 12, right: 12),
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          spreadRadius: 0.7)
                    ]),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .8,
                child: Column(
                  children: [
                    QuillToolbar.basic(controller: controller),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: Container(
                        height: 400,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: QuillEditor.basic(
                          controller: controller,
                          readOnly: false, // true for view only mode
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
                          var json = jsonEncode(
                              controller.document.toDelta().toJson());
                          var textc = controller.document.toPlainText();
                          Setting.publierCtrl.pub.value.contentJson = json;
                          Setting.publierCtrl.pub.value.contenu = textc;
                          Setting.publierCtrl.pub.value.titre = widget.titre;
                          Setting.publierCtrl.pub.value.image = widget.image;
                          Setting.publierCtrl.pub.value.id = Setting.user!.uid;

                          // if (controller.t)
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DetailPub()));
                          });
                        },
                        child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Icon(
                              Icons.navigate_next,
                              size: 30,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
