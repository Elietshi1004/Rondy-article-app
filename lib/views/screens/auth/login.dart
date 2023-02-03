import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rondyarticleapp/Setting.dart';
import 'package:rondyarticleapp/views/screens/home/home_screen.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/constants/constants.dart';
import '../../base/textField/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    singInUser();
    loginAnomyme();
    super.initState();
  }

  @override
  void dispose() {
    isLoading;
    controllerEmail;
    controllerPassword;
    super.dispose();
  }

  void loginAnomyme() {
    setState(() {
      isLoading = true;
    });
    final res = AuthController().loginAnomyme;
    // ignore: unrelated_type_equality_checks
    if (res == "success") {
      // setState(() {
      //   Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      // });
      Get.offNamed("/home");
    }
    setState(() {
      isLoading = false;
    });
  }

  void singInUser() async {
    setState(() {
      isLoading = true;
    });
    printDebug("pwd ${controllerPassword.text}");
    String res = await AuthController().loginUser(
        email: controllerEmail.text, password: controllerPassword.text);
    if (res == "success") {
      // ignore: use_build_context_synchronously
      // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);

      Get.offNamed("/home");
      Setting.homeCtrl.setValueStorage("login", true);
      // Get.off(const HomeScreen());
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                height: 90,
              ),
              SizedBox(
                height: 50,
                child: TextInputField(
                  controller: controllerEmail,
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
                  controller: controllerPassword,
                  hintText: "PassWord...",
                  iconSuffixIcon: Icons.password,
                  isobscure: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: singInUser,
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
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/compte');
                  },
                  child: const Text(
                    "Cree un compte",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  )),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    //loginAnomyme();
                    Navigator.pushReplacementNamed(context, '/home');
                  });
                },
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue)),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Center(
                          child: Text(
                            "Se connecter sans compte",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
