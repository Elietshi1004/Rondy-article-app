import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as fq;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../Setting.dart';
import '../../../utils/constants/constants.dart';

class DetailPub extends StatefulWidget {
  const DetailPub({super.key});

  @override
  State<DetailPub> createState() => _DetailPubState();
}

class _DetailPubState extends State<DetailPub> {
  late fq.QuillController controller;
  @override
  void initState() {
    super.initState();
    var myJSON = jsonDecode(Setting.publierCtrl.pub.value.contentJson);

    controller = fq.QuillController(
      document: fq.Document.fromJson(myJSON),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var pub = Setting.publierCtrl.pub.value;

    Size size = MediaQuery.of(context).size;
    File? img = pub.image.isEmpty ? null : File(pub.image);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            height: Setting.getHeight(context),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ajouter l'article",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    if (img != null)
                      Image.file(img)
                    else
                      SvgPicture.asset(
                        "assets/svg/girl-doing-online-payment.svg",
                        height: 200,
                        width: 200,
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 600,
                      child: Column(
                        children: [
                          Text(
                            pub.titre,
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Flexible(
                            child: Container(
                              height: 400,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
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
                    loading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  var rs =
                                      await Setting.publierCtrl.addArticle();
                                  setState(() {
                                    loading = false;
                                  });
                                  if (rs == "success") {
                                    Get.offNamed("/home");
                                  } else {
                                    showSnakBar(rs, context);
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.1,
                                            spreadRadius: 0.7)
                                      ]),
                                  child: const Center(
                                      child: Text(
                                    "Publier",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          )
                  ]),
            ),
          ),
        ));
  }
}
