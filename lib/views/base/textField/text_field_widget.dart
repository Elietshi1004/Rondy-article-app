import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final bool isobscure;
  final IconData? iconPrefix;
  final IconData? iconSuffixIcon;
  final Widget? iconButton;
  final int? maxLength;
  const TextInputField(
      {Key? key,
      required this.controller,
      this.labelText,
      this.isobscure = false,
      this.iconPrefix,
      this.iconSuffixIcon,
      this.hintText,
      this.maxLength,
      this.iconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(iconPrefix),
        suffixIcon: iconButton ?? Icon(iconSuffixIcon),
        labelStyle: const TextStyle(fontSize: 17),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      obscureText: isobscure,
    );
  }
}
