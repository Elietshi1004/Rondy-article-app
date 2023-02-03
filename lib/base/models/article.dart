import 'package:cloud_firestore/cloud_firestore.dart';

class Article{
  String titre;
  String image;
  String contenu; 
  String sousTitre;

  Article({required this.titre, required this.image, required this.contenu, required this.sousTitre});
  Map<String, dynamic> tojson()=>{
    "titre":titre,
    "image":image,
    "contenu":contenu,
    "sous_titre":sousTitre
  };

  static Article fromSnap(DocumentSnapshot snap){
    var snapShot = snap.data() as Map<String,dynamic>;
    return Article(
      titre: snapShot["titre"],
      image: snapShot["image"],
      contenu: snapShot["contenu"],
      sousTitre: snapShot["sousTitre"]);
  }
}