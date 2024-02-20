import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class QueryFunctions {
  // Initialize Firebase app
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Function to get UserID based on User_Email
  static Future<String?> getUserId(String userEmail) async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref();

      // Query the database to find the user node with the matching email
      DatabaseEvent snapshot = await dbRef.child('Users').orderByChild('User_Email/Value').equalTo(userEmail).once();

      Map<dynamic, dynamic>? users = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (users == null || users.isEmpty) {
        print("No user found with email: $userEmail");
        return null;
      }

      String? userID;

      users.forEach((key, value) {
        userID = key;
      });
    } catch (error) {
      // Handle any errors that occur during the database operation
      print("Error retrieving user ID: $error");
      return null;
    }
  }
}
