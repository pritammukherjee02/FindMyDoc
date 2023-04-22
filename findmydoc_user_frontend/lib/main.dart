import 'package:find_my_doc/controllers/AuthAndUserController/auth_controller.dart';
import 'package:find_my_doc/controllers/AuthAndUserController/user_controller.dart';
import 'package:find_my_doc/controllers/DatabaseController/database_controller.dart';
import 'package:find_my_doc/controllers/MainPageController/main_page_controller.dart';
import 'package:find_my_doc/routing/routes.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Putting Controllers into dependency injection
  Get.put<AuthController>(AuthController());
  Get.put<UserController>(UserController());
  Get.put<MainPageController>(MainPageController());
  Get.put<DatabaseController>(DatabaseController());

  // Running the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Find My Doc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: primaryThemeColor, //Deep Brown
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: bodyTextFontSize.toDouble()),
          labelMedium: TextStyle(fontSize: miniTextFontSize.toDouble()),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryThemeColor,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
      ),
      initialRoute: Routes.getSplashRoute(),
      getPages: Routes.routes,
    );
  }
}
