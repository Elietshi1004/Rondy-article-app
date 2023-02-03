import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Setting.dart';
import '../../base/models/publication.dart';
import '../screens/home/detail.dart';

Widget getLineArticle(Publier publier) {
  var titleTextStyle = TextStyle(
    color: Colors.black87,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  return ListTile(
    onTap: () {
      Get.to(ArticleUI(
        publier: publier,
      ));
    },
    title: Text(
      publier.titre,
      style: titleTextStyle,
    ),
    subtitle: Text(
        "${Setting.parseDay(publier.dt == null ? "" : publier.dt.toString())} ${Setting.parseDate(publier.dt == null ? "" : publier.dt.toString())}"),
    trailing: Container(
      width: 80.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: (publier.image.isNotEmpty
                    ? NetworkImage(publier.image)
                    : const AssetImage("assets/gif/man-holding-note.gif"))
                as ImageProvider,
            fit: BoxFit.cover,
          )),
    ),
  );
}
