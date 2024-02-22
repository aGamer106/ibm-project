import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ArCoreController? coreController;

  @override
  void dispose() {
    coreController?.dispose();
    super.dispose();
  }

  void augmentedRealityViewCreated(ArCoreController controller) {
    coreController = controller;
    // loadAsset();
    displayCube(controller);
    print('ARCore Controller is initialized');
    displayModelWithArCoreReferenceNode(controller);
  }

  void displayCube(ArCoreController controller) {
    final material = ArCoreMaterial(color: Colors.blue);
    final cube = ArCoreCube(
      materials: [material],
      size: vector64.Vector3(0.1, 0.1, 0.1), // Define the size of the cube
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(0, 0, -1), // Place the cube in front of the camera
    );

    controller.addArCoreNode(node);
  }

  // You can use this method later to display your image as texture
  void displayModelWithArCoreReferenceNode(ArCoreController controller) {
    print('Attempting to display 3D model...');
    final node = ArCoreReferenceNode(
      name: "Card", // The name of your 3D model file
      object3DFileName: "avatars/Astro&Card.glb", // Path to your 3D model file
      position: vector64.Vector3(0, 0, -1), // Adjust position as needed
      scale: vector64.Vector3.all(1.0), // Adjust scale as needed
    );

    controller.addArCoreNode(node).then((_) {
      print('3D model added successfully');
    }).catchError((e) {
      print("Error adding AR node: $e");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AR Screen"),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
        enableTapRecognizer: true, // If you want to handle tap gestures in the AR view
      ),
    );
  }
}
