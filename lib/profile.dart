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


  static Future<List<String>?> getCardData(String? userID) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('AppDB/Business_Cards').get();

      if (snapshot.exists) {
        List<String> res = [];

        for (var entry in (snapshot.value as Map<dynamic, dynamic>).entries) {
          // Check if the 'User_ID' field matches the provided userID
          if (entry.value['User_ID'] == userID) {
            // If matched, extract the required fields and add them to the result list
            res.add(entry.value['Card_Avatar_Type'] ?? "");
            res.add(entry.value['Job_Title'] ?? "");
            res.add(entry.value['Phone_Number'] ?? "");


            return res;
          }
        }
        // If no matching user ID found in any business card
        print('No business card available for user with ID: $userID');
      } else {
        // Handle the case where 'Business_Cards' node does not exist
        print('Business_Cards node does not exist');
      }
      // Return null if no data found or if there's an issue with database retrieval
      return null;
    } catch (e) {
      // Handle any potential errors that might occur during database retrieval
      print('Error fetching business card data: $e');
      return null;
    }
  }



  }
