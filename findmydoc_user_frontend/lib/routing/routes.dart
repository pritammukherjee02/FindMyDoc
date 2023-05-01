import 'package:find_my_doc/pages/AuthPage/auth_page.dart';
import 'package:find_my_doc/pages/CategoryPage/category_page.dart';
import 'package:find_my_doc/pages/LoginAndSignUpPage/login_page.dart';
import 'package:get/get.dart';

import '../pages/SplashPage/splash_page.dart';

class Routes {
  static String splashPage = '/splash_page';
  static String authRoute = '/auth_page';
  static String loginPage = '/login_page';
  static String homePage = '/home';
  static String categoryPage = '/category_page';
  static String doctorPage = '/doctor';
  static String clinicPage = '/clinic';
  static String calenderPage = '/calender';
  static String appointmentsPage = '/appointments';
  static String appointmentPage = '/appointment';

  static String getSplashRoute() => splashPage;
  static String getHomeRoute() => homePage;
  static String getAuthRoute() => authRoute;
  static String getCategoryRoute() => categoryPage;

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashPage()),
    GetPage(name: authRoute, page: () => const AuthPage()),
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(name: categoryPage, page: () => CategoryPage()),
  ];
}
