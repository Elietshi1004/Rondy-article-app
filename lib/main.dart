import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:rondyarticleapp/Setting.dart';
import 'package:rondyarticleapp/provider/user_provider/user_provider.dart';
import 'package:rondyarticleapp/utils/routes/routes.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Setting.initUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: GetMaterialApp(
        title: 'Articles',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: (Setting.homeCtrl.getValueStorage("login") ?? false) &&
                Setting.user != null
            ? "/home"
            : '/',
        routes: Routes.listeInitial,
      ),
    );
  }
}
