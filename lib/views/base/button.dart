import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonIcon extends StatelessWidget {
  ButtonIcon({super.key, this.oprens, required this.textInfo, required this.icon});

  Function? oprens;
  final String textInfo;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container();
  }
}