import 'package:find_my_doc/controllers/MainPageController/main_page_controller.dart';
import 'package:find_my_doc/pages/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        toolbarOpacity: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: GetX<MainPageController>(builder: (controller) {
        return selectView();
      }),
    );
  }

  Widget selectView() {
    final MainPageController mainPageController = Get.find();

    switch (mainPageController.currentPage.value) {
      case 'home':
        return const HomePage();
      default:
        return const HomePage(); // TODO: Will be 404 page
    }
  }
}
