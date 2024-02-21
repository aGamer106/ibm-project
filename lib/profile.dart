import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class QueryFunctions {
  // Initialize Firebase app
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Function to get UserID based on User_Email
  static Future<String?> getID(String userEmail) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('AppDB/Users').get();
    if (snapshot.exists) {
      for (var entry in (snapshot.value as Map<dynamic, dynamic>).entries) {
        if (entry.value['User_Email'] == userEmail) {
          return entry.key;
        }
      }
    } else {
      print('No data available.');
    }
    return null;
    }



  }
