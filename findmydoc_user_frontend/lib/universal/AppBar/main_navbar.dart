import 'package:find_my_doc/controllers/AuthAndUserController/auth_controller.dart';
import 'package:find_my_doc/controllers/AuthAndUserController/user_controller.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainCustomNavbar extends StatelessWidget {
  MainCustomNavbar({super.key});

  final AuthController authController = Get.find();
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      backgroundColor: primaryThemeColor,
      automaticallyImplyLeading: false,
      expandedHeight: 180,
      collapsedHeight: 100,
      leadingWidth: 0,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: primaryThemeColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile image
            CircleAvatar(
              radius: 30,
              child: ClipOval(
                child: Image.network(userController.getUserProfileImageURL()!),
              ),
            ),

            //Spacing
            const SizedBox(
              width: 16,
            ),

            // Salutation and name
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: TextStyle(
                    fontSize: bodyTextFontSize.toDouble(),
                    fontWeight: FontWeight.w600,
                    color: const Color(0x85FFFFFF),
                  ),
                ),

                // Spacing
                const SizedBox(
                  height: 5,
                ),

                Text(
                  userController.getUserName()!,
                  style: TextStyle(
                    fontSize: largeTextFontSize.toDouble(),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0, top: 10.0),
          child: IconButton(
            onPressed: () {
              // TODO: Change the functionality
              authController.signOut();
            },
            iconSize: 35,
            icon: const Icon(Icons.notifications_none_rounded),
            // color: Colors.black,
          ),
        )
      ],
    );
  }
}
