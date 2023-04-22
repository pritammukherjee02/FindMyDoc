import 'package:find_my_doc/controllers/AuthAndUserController/auth_controller.dart';
import 'package:find_my_doc/universal/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controller to use when sending the login request
  final phoneNumberFieldController = TextEditingController();
  final AuthController authController = Get.find();

  // Send OTP when clicked
  void sendOTP() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: const RangeMaintainingScrollPhysics(),
        children: [
          // Spacing
          const SizedBox(
            height: 100,
          ),
          // Brand image
          Center(
            child: Image.asset(
              'lib/assets/branding/brand.png',
              width: 280,
            ),
          ),

          // Spacing
          const SizedBox(
            height: 10,
          ),

          // Subtitle for sales
          Center(
            child: Text(
              'Everything Doctor related',
              style: TextStyle(
                  fontSize: xLargeTextFontSize.toDouble(),
                  color: Colors.black54,
                  fontWeight: FontWeight.w400),
            ),
          ),

          // Spacing
          const SizedBox(
            height: 70,
          ),

          // Phone number text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              autofocus: true,
              controller: phoneNumberFieldController,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFCCD6DD)),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryThemeColor),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                  color: secondaryThemeColor,
                ),
              ),
            ),
          ),

          // Spacing
          const SizedBox(height: 45),

          // Send OTP
          GestureDetector(
            onTap: sendOTP,
            child: Container(
              decoration: const BoxDecoration(
                  color: primaryThemeColor,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Text(
                  'Send OTP',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: mediumBigTextFontSize.toDouble(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Spacing
          const SizedBox(
            height: 50,
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: secondaryThemeColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'OR',
                    style: TextStyle(color: secondaryThemeColor),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: secondaryThemeColor,
                  ),
                ),
              ],
            ),
          ),

          // Spacing
          const SizedBox(
            height: 50,
          ),

          // OAuth2 services like Google
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OAuthSquareTile(
                image: 'lib/assets/google.png',
                providerBrand: 'Google',
                onTap: () => authController.signInWithGoogleOAuth(),
                // onTap: () {},
              ),
            ],
          ),

          // Spacing
          const SizedBox(
            height: 50,
          ),
        ],
      )),
    );
  }
}

class OAuthSquareTile extends StatelessWidget {
  final String image;
  final String providerBrand;
  final void Function()? onTap;
  const OAuthSquareTile(
      {super.key,
      required this.image,
      required this.providerBrand,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              image,
              height: 30,
            ),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Text(
                'Sign in with $providerBrand',
                style: TextStyle(
                  fontSize: mediumBigTextFontSize.toDouble(),
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
