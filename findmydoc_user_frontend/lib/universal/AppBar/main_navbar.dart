import 'package:find_my_doc/controllers/AuthAndUserController/auth_controller.dart';
import 'package:find_my_doc/controllers/AuthAndUserController/user_controller.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainCustomNavbar extends StatelessWidget {
  MainCustomNavbar({super.key});

  final AuthController authController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning',
                style: TextStyle(
                  fontSize: mediumBigTextFontSize.toDouble(),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Mukherjee',
                style: TextStyle(
                  fontSize: xLargeTextFontSize.toDouble(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Profile Picture
          // Profile image
          CircleAvatar(
            radius: 30,
            child: ClipOval(
              child: Image.network(userController.getUserProfileImageURL()!),
            ),
          ),
        ],
      ),
    );
  }
}
