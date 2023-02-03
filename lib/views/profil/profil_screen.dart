import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rondyarticleapp/utils/constants/constants.dart';

import '../../Setting.dart';
import '../../controller/auth_controller.dart';

import 'package:rondyarticleapp/base/models/user.dart' as model;

import '../../utils/constants/selectedImage.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilUI extends StatefulWidget {
  const ProfilUI({Key? key, this.user}) : super(key: key);
  final model.User? user;
  @override
  State<ProfilUI> createState() => _ProfilUIState();
}

class _ProfilUIState extends State<ProfilUI> {
  // static final String path = "lib/src/pages/profile/profile10.dart";
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerBio = TextEditingController();

  bool isLoading = false;
  File? _image;

  Future getImage(ImageSource source) async {
    XFile image = await pickImage(source);

    //if(image == null) return ;
    //final imageTempory = File(image.path);
    setState(() {
      _image = File(image.path);
    });
  }

  void singOutUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthController().singOut();
    if (res == "success") {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = (widget.user ?? Setting.userCtrl.user.value);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: widget.user == null
          ? null
          : AppBar(
              title: const Text("Profil"),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: widget.user != null,
              child: const SizedBox(
                height: 100,
              ),
            ),
            Container(
              height: 250,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      var img =
                          (widget.user ?? Setting.userCtrl.user.value).image;
                      if (!(img == null || img.isEmpty)) {
                        Get.defaultDialog(
                            title: "Profil",
                            content: Image.network(
                              img.toString(),
                              fit: BoxFit.contain,
                            ));
                      }
                    },
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: _image != null
                          ? Image.file(_image!)
                          : (widget.user ?? Setting.userCtrl.user.value)
                                          .image ==
                                      null ||
                                  (widget.user ?? Setting.userCtrl.user.value)
                                      .image!
                                      .isEmpty
                              ? Image.asset(
                                  "assets/svg/male-avatar.gif",
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  (widget.user ?? Setting.userCtrl.user.value)
                                      .image
                                      .toString(),
                                  loadingBuilder: (c, w, i) {
                                    if (i == null) return w;
                                    return const CircularProgressIndicator();
                                  },
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 0.8),
                    child: MaterialButton(
                      minWidth: 0,
                      elevation: 0.5,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        if (widget.user == null) {
                          getImage(ImageSource.gallery);
                        }
                      },
                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: controllerName,
                    enabled: widget.user == null,
                    decoration: InputDecoration(
                      labelText: user.nameUser,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: controllerEmail,
                    enabled: widget.user == null,
                    decoration: InputDecoration(
                      labelText: user.email,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: controllerBio,
                    enabled: widget.user == null,
                    decoration: InputDecoration(
                      labelText: user.bio,
                    ),
                  ),

                  // const SizedBox(height: 10.0),
                  // InputDatePickerFormField(
                  //   firstDate: DateTime(DateTime.now().year - 5),
                  //   lastDate: DateTime(DateTime.now().year + 5),
                  //   initialDate: DateTime.now(),
                  //   fieldLabelText: "Date of Birth",
                  // ),

                  const SizedBox(height: 10.0),
                  Visibility(
                    visible: widget.user == null,
                    child: Text(
                      "Laissez vide ce que vous ne modifiez pas",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  Visibility(
                    visible: widget.user == null,
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : MaterialButton(
                            color: Colors.pink,
                            onPressed: () async {
                              if ((controllerEmail.text.trim().isNotEmpty &&
                                      controllerEmail.text.trim().length < 3) ||
                                  (controllerName.text.trim().isNotEmpty &&
                                      controllerName.text.trim().length < 3)) {
                                showSnakBar(
                                    "Le nom ou email doivent avoir au moins trois caractères",
                                    context);
                                return;
                              }
                              var res = await Get.defaultDialog<bool>(
                                  barrierDismissible: false,
                                  title: "Confirmer",
                                  middleText:
                                      "Vous êtes sûr de modifier vos informations?",
                                  onConfirm: () {
                                    Get.back(result: true);
                                  },
                                  onCancel: () {},
                                  textCancel: "Annuler");
                              if (res ?? false) {
                                setState(() {
                                  isLoading = true;
                                });
                                model.User user = Setting.userCtrl.user.value;
                                user.email =
                                    controllerEmail.text.trim().isNotEmpty
                                        ? controllerEmail.text.trim()
                                        : Setting.userCtrl.user.value.email;

                                user.nameUser =
                                    controllerName.text.trim().isNotEmpty
                                        ? controllerName.text.trim()
                                        : Setting.userCtrl.user.value.nameUser;

                                user.bio = controllerBio.text.trim().isNotEmpty
                                    ? controllerBio.text.trim()
                                    : Setting.userCtrl.user.value.bio;

                                bool result =
                                    await Setting.userCtrl.updateUser(user);
                                if (result) {
                                  if (_image != null) {
                                    await Setting.userCtrl
                                        .updateUserProfil(user, _image!.path);
                                  }
                                  Get.defaultDialog(
                                      barrierDismissible: false,
                                      title: "Modification effectuée",
                                      middleText:
                                          "Vos informations ont été modifiées avec succès",
                                      onConfirm: () {
                                        Get.back();
                                      });
                                } else {
                                  showSnakBar(
                                      "La modification a échouée\nVeuillez recommencer",
                                      context);
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Text("Mettre à Jour"),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.user});
  final model.User? user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  File? _image;

  Future getImage(ImageSource source) async {
    File image = await pickImage(source);

    //if(image == null) return ;
    //final imageTempory = File(image.path);
    setState(() {
      _image = image;
    });
  }

  void singOutUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthController().singOut();
    if (res == "success") {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // singOutUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Center(
            child: Stack(
              children: [
                _image != null
                    ? Image.file(
                        _image!,
                        height: 150,
                        width: 150,
                      )
                    : Image.asset(
                        "assets/svg/male-avatar.gif",
                        height: 150,
                        width: 150,
                      ),
                Positioned(
                    bottom: -10,
                    right: -5,
                    child: IconButton(
                      onPressed: () {
                        if (widget.user == null) getImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.camera),
                    ))
              ],
            ),
          ),
        ),
        const Center(
            child: Text(
          "nom user",
          style: TextStyle(fontSize: 15),
        )),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: const [
              Text(
                "Article publié",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: singOutUser,
          child: Container(
            height: 45,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.blue,
                    )
                  : const Text("Se deconnecter",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
            ),
          ),
        )
      ],
    );
  }
}
