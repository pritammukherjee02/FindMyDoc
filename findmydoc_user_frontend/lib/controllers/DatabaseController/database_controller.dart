import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:io';

class DatabaseController extends GetxController {
  String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  static FirebaseFirestore db = FirebaseFirestore.instance;
  final bool useEmulator = true;

  @override
  void onInit() {
    super.onInit();
    if (useEmulator) {
      db.useFirestoreEmulator(host, 5872);
      db.settings = const Settings(
        persistenceEnabled: true,
      );
    }
  }
}
