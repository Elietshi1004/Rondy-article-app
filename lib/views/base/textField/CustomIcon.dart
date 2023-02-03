import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 30,
      width: 45,
        child: Stack(
          children: [
            Container(
              margin:const EdgeInsets.only(right: 10),
              width: 38,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 144, 233),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Container(
              margin:const EdgeInsets.only(left: 10),
              width: 38,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 11, 144, 233),
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            Center(
              child: Container(
                height: size.height,
                width: 38,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)
                ),
                child: const Icon(Icons.add, color: Colors.black,size: 30,),
              ),
            )
          ],
        ),
    );
  }
}
