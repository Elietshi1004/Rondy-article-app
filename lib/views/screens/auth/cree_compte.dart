import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Setting.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/selectedImage.dart';
import '../../base/textField/text_field_widget.dart';

class CreeCommpte extends StatefulWidget {
  const CreeCommpte({super.key});

  @override
  State<CreeCommpte> createState() => _CreeCommpteState();
}

class _CreeCommpteState extends State<CreeCommpte> {
  File? _image;

  Future getImage(ImageSource source) async {
    XFile image = await pickImage(source);

    //if(image == null) return ;
    //final imageTempory = File(image.path);
    setState(() {
      _image = File(image.path);
    });
  }

  final TextEditingController controllerEmailCompte = TextEditingController();
  final TextEditingController controllerNameUser = TextEditingController();
  final TextEditingController controllerBio = TextEditingController();
  final TextEditingController controllerPasswordCompte =
      TextEditingController();
  bool isLoading = false;

  //singUp user
  void singUpUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthController().singUser(
        nameUser: controllerNameUser.text,
        email: controllerEmailCompte.text,
        bio: controllerBio.text,
        password: controllerPasswordCompte.text,
        file: _image);
    if (res == 'success') {
      // ignore: use_build_context_synchronously
      // Navigator.pushNamedAndRemoveUntil(
      //     context, '/accueilscreen', (route) => false);
      Get.offNamed("/home");
      Setting.homeCtrl.setValueStorage("login", true);
    } else {
      // ignore: use_build_context_synchronously
      showSnakBar(res, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1.1,
                            blurRadius: 0.9)
                      ]),
                  child: const Center(
                      child: Text(
                    "MA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                child: Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundImage: FileImage(
                                _image!,
                              ),
                            )
                          : Image.asset(
                              "assets/svg/male-avatar.gif",
                              height: 70,
                              width: 70,
                            ),
                      Positioned(
                          bottom: -10,
                          right: -5,
                          child: IconButton(
                            onPressed: () {
                              bottomsheetProfil();
                            },
                            icon: const Icon(Icons.camera),
                          ))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                child: TextInputField(
                  controller: controllerNameUser,
                  hintText: "Name User...",
                  iconSuffixIcon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextInputField(
                  controller: controllerBio,
                  hintText: "Bio...",
                  iconSuffixIcon: Icons.person,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextInputField(
                  controller: controllerEmailCompte,
                  hintText: "Email...",
                  iconSuffixIcon: Icons.mail,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                child: TextInputField(
                  controller: controllerPasswordCompte,
                  hintText: "Password...",
                  iconSuffixIcon: Icons.password,
                  isobscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: singUpUser,
                child: Container(
                  height: 45,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.7,
                            blurRadius: 1.2)
                      ]),
                  child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Se connecter",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomsheetProfil() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    getImage(ImageSource.gallery);
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.image),
                  title: Text(
                    "Gallerie",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    getImage(ImageSource.camera);
                  });
                },
                child: const ListTile(
                  leading: Icon(Icons.camera),
                  title: Text(
                    "Camera",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
