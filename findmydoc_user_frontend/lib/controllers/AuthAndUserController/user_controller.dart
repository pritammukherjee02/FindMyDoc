import 'package:find_my_doc/controllers/DatabaseController/database_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  String? getUserName() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.displayName;
    } else {
      return "";
    }
  }

  String? getUserProfileImageURL() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser!.photoURL;
    } else {
      return "";
    }
  }

  Future<List> getUserAppointments() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var snapshot = await DatabaseController.db
          .collection('appointments')
          .doc('n0eIPcMORgmP3MznUAJv')
          .collection('list_of_appointments')
          .get();

      List data = [];
      for (var recordSnapshot in snapshot.docs) {
        data.add(recordSnapshot.data());
      }

      return data;
    } else {
      return [];
    }
  }
}
