import 'package:find_my_doc/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.getAuthRoute());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/branding/brand.png',
              width: 280,
            ),
            const SizedBox(height: 30),
            // const CircularProgressIndicator(),
            // Text(
            //   'Shopydoo',
            //   style: TextStyle(
            //     fontSize: xxLargeTextFontSize.toDouble(),
            //     color: primaryThemeColor,
            //     fontWeight: FontWeight.w700,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
