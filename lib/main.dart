//modified the entire starter template, just as a heads-up
//new structure with the latest updates can be found below:
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:untitled/submit_data_form.dart';
import 'qr_scanner_overlay.dart';
import 'package:firebase_core/firebase_core.dart';
import 'generate_qr_screen.dart';
import 'text_to_speech.dart';
//import 'package:uuid/uuid.dart';
//import 'dart:math';
//import 'card.dart';
//import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          databaseURL: 'https://ibm-group-c-default-rtdb.europe-west1.firebasedatabase.app/',
          apiKey: 'AIzaSyCZle2D58-dsDmpA26KkNOvU08cU-iV7S4',
          appId: '1:191934931736:android:759aef3382482a206b346d',
          messagingSenderId: '191934931736',
          projectId: 'ibm-group-c')
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'flutter',
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //we need a controller for our Camera to actually work; I named it cameraController so that it's self-explanatory from the name
  MobileScannerController cameraController = MobileScannerController();

  void navigateToTextToSpeechPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TextToSpeechPage()),
    );
  }

  // get barcode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRScanner'),
        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GenerateQRScreen()),
              );
            },
            icon: const Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () {
              cameraController.switchCamera();
            },
            icon: const Icon(Icons.camera_rear_outlined),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) async {
              final String? barcodeValue = barcode.rawValue;
              debugPrint('Barcode Found! $barcodeValue !');
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            right: 30,
            bottom: 80,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertDataPage()),
                );
              },
              child: const Icon(Icons.add),
            ),
          ),
          Positioned(
            left: 30,
            bottom: 80,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RelTimeData()),
                );
              },
              child: const Icon(Icons.data_object),
            ),
          ),
        ],
      ),
    );
  }
}



class RelTimeData extends StatelessWidget {
  RelTimeData({super.key});
  // Adjusted reference to include 'AppDB/Users'
  final ref = FirebaseDatabase.instance.ref('AppDB/Users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real time database"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    // Assuming 'User_Email' and 'Last_Name' are direct children of each user node
                    return Card(
                      color: Colors.white10,
                      child: ListTile(
                        title: Text(snapshot.child('First_Name').value.toString()),
                        subtitle: Text(snapshot.child('Last_Name').value.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min, // This is needed to keep the Row tight around its children
                          children: [
                            Text(snapshot.child('User_Email').value.toString()), // Assuming you still want to display this here
                            IconButton(
                              icon: const Icon(Icons.volume_up),
                              onPressed: () async {
                                final tts = FlutterTts();
                                String userDetail = "First Name: ${snapshot.child('First_Name').value}, Last Name: ${snapshot.child('Last_Name').value}, Email: ${snapshot.child('User_Email').value}";
                                await tts.setLanguage("en-UK");
                                await tts.setPitch(1);
                                await tts.speak(userDetail);
                                // Here, instead of just speaking, you'd also generate and upload the audio file, see Step 3.
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              )
          ),
        ],
      ),
    );
  }
}



//write 2 functions
//1. Function that returns the User ID
//2. A function that takes the user ID and prints out to the screen the business card


//1. push test data onto the database, using the push() function so that it generates a new UUID
// - wanna push a User, a Business Card, and a Profile
//2. once we figure out how to access a record by its UUID - Ibrahim