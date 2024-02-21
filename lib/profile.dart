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


  static Future<List<List<String>?>?> getCardData(String? userID) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('AppDB/Business_Cards').get();

      if (snapshot.exists) {
        List<List<String>> res = [];

        for (var entry in (snapshot.value as Map<dynamic, dynamic>).entries) {
          // Check if the 'User_ID' field matches the provided userID
          if (entry.value['User_ID'] == userID) {
            // If matched, extract the required fields and add them to the result list
            List<String> data = [];
            data.add(entry.value['Card_Avatar_Type'] ?? "");
            data.add(entry.value['Job_Title'] ?? "");
            data.add(entry.value['Phone_Number'] ?? "");

            List<String> profileIDs = [];
            if(entry.value['Profiles'] != null){
              List<String> profileIDs = [];
              (entry.value['Profiles'] as Map<dynamic, dynamic>).forEach((key, value) {
                  profileIDs.add(value);

              });
              res.add(data);
              res.add(profileIDs);

            }
            return res;
          }
        }
        print('No business card available for user with ID: $userID');
      } else {
        // Handle the case where 'Business_Cards' node does not exist
        print('Business_Cards node does not exist');
      }
      return null;
    } catch (e) {
      print('Error fetching business card data: $e');
      return null;
    }
  }

  static Future<List<String>?> getProfile(String? profileID) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('AppDB/Profiles').get();
    if (snapshot.exists) {
      List<String> res = [];
      for (var entry in (snapshot.value as Map<dynamic, dynamic>).entries) {
        if (entry.key == profileID) {
          res.add(entry.value['Card_ID'] ?? "");
          res.add(entry.value['Profile_Link'] ?? "");
          res.add(entry.value['Profile_Name'] ?? "");

          return res;
        }
      }
    } else {
      print('No data available.');
    }
    return null;
  }



  }
