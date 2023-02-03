import 'package:flutter/material.dart';

class OpenScreen extends StatefulWidget {
  const OpenScreen({super.key});

  @override
  State<OpenScreen> createState() => _OpenScreenState();
}

class _OpenScreenState extends State<OpenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Image.asset(
              "assets/svg/undraw_Good_team_re_hrvm.png",
              height: 250,
              width: 350,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Publier vos articles",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 11,
                ),
                const Text(
                  "Suivez le processus jusqu'à la fin pour publier dans notre application. Notez que votre article après revision peut être supprimée s'il n'est pas conforme à nos normes",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushNamed(context, "/titre");
                      });
                    },
                    child: const Text("Publier"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
