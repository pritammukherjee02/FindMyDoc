// The only FILE (apart from the AuthPage) that you need to
// change if you want to change the provider for Authorization

import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  void sendOTPForLogin(String phoneNumber) {
    // The function to call from the login page for OTP verification
  }

  signInWithGoogleOAuth() async {
    // When you want to sign in using Google

    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    // Finally, Sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
