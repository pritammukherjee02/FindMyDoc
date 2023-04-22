import 'package:get/get.dart';

class MainPageController extends GetxController {
  var currentPage = 'home'.obs;

  void changePage(String newPage) {
    currentPage.value = newPage;
  }
}
