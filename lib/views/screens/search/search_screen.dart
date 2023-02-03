import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rondyarticleapp/Setting.dart';

import '../../../base/models/publication.dart';
import '../../base/textField/text_field_widget.dart';
import '../../base/tilehome.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  bool loading = false;
  var list = <Publier>[];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.4,
                          blurRadius: 0.7)
                    ]),
                child: TextInputField(
                  controller: controller,
                  labelText: "Search",
                  // iconPrefix: Icons.search,
                  iconButton: loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              setState(() {
                                loading = true;
                              });
                              Future.delayed(const Duration(seconds: 1), () {
                                list = Setting.publierCtrl.mapListPub.values
                                    .where((e) => e.titre
                                        .toLowerCase()
                                        .contains(
                                            controller.text.toLowerCase()))
                                    .toList();
                                setState(() {
                                  loading = false;
                                });
                              });
                            }
                          },
                          icon: const Icon(Icons.search)),
                ),
              ),
            ),
            if (list.isEmpty)
              SvgPicture.asset("assets/svg/girl-doing-online-payment.svg")
            else
              const Text(
                "Articles trouvés",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [getLineArticle(list[index]), const Divider()],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
