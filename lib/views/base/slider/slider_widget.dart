import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: size.width * 0.6,
        ),
        const SizedBox(
          height: 60,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.5,
                height: 1.5),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
