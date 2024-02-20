import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class QueryFunctions {
  // Initialize Firebase app
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  // Function to get UserID based on User_Email
  static Future<String?> getCardID(String userEmail) async {
    try {
      DatabaseReference dbRef = FirebaseDatabase.instance.ref();

      // Query the database to find the user node with the matching email
      DatabaseEvent snapshot = await dbRef.child('Users').orderByChild('User_Email/Value').equalTo(userEmail).once();

      String? businessCardID = snapshot.snapshot.child('Business_Card').value.toString();

      if (businessCardID == null || businessCardID.isEmpty) {
        print("No user found with email: $userEmail");
        return null;
      }else{
        return businessCardID;
      }
    } catch (error) {
      // Handle any errors that occur during the database operation
      print("Error retrieving user ID: $error");
      return null;
    }
  }
}
