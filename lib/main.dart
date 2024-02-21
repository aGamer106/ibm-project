//modified the entire starter template, just as a heads-up
//new structure with the latest updates can be found below:
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'qr_scanner_overlay.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'card.dart';
import 'generate_qr_screen.dart';
import 'text_to_speech.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
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
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const GenerateQRScreen()),
              );
            },
            icon: const Icon(Icons.qr_code)
          ),
          IconButton(
            onPressed: navigateToTextToSpeechPage,
            icon: const Icon(Icons.volume_up)
          ),

          IconButton(onPressed: (){cameraController.switchCamera();
        },
            icon: const Icon(Icons.camera_rear_outlined))] //actions performed by the camera - this basically allows the user to switch between front-facing camera to back-facing camera; The icon takes a constant value here for now.
      ),
      //wrapping everything as a Stack with children - the children of this Stack object will be the MobileScanner
      body: Stack(children: [MobileScanner(
          allowDuplicates: false,
          controller: cameraController, //pass the controller to the object itself here in order for it to use
          onDetect: (barcode, args) async {
            final String? barcodeValue = barcode.rawValue;
            debugPrint('Barcode Found! $barcodeValue !');

            if (barcodeValue == 1){
              businessCard testCard= businessCard(
              phoneNumber: "123",
              firstName: "Ibrahim",
              lastName: "Ahmed",
              jobTitle: "Student",
              );
              testCard.displayCard(context);
            }
          }),
        QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
      ]),
        //the closer to the end of the list, the higher the priority on the stream, showing on top of everything else
    );
  }
}