//modified the entire starter template, just as a heads-up
//new structure with the latest updates can be found below:
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

void main() {
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

  // get barcode => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRScanner'),
        actions: [IconButton(onPressed: (){cameraController.switchCamera();
        },
            icon: const Icon(Icons.camera_rear_outlined))] //actions performed by the camera - this basically allows the user to switch between front-facing camera to back-facing camera; The icon takes a constant value here for now.
      ),
      body: MobileScanner(
          allowDuplicates: false,
          controller: cameraController, //pass the controller to the object itself here in order for it to use
          onDetect: (barcode, args) {
            debugPrint('Barcode Found! ' + barcode.rawValue!);
      })
    );
  }
}