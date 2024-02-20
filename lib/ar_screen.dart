import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen>
{
  ArCoreController? coreController;
  augmentedRealityViewCreated(ArCoreController controller)
  {
    coreController = controller;

    displayCube(coreController!);
  }

  displayCube(ArCoreController controller)
  {
    final materials = ArCoreMaterial(
      color: Colors.indigo,
      metallic: 2,
    );

    final cube = ArCoreCube(
        size: vector64.Vector3(0.5,0.5,0.5),
        materials: [materials],
    );

    final node = ArCoreNode(
      shape: cube,
      position: vector64.Vector3(-0.5,0.5,-3.5),
    );

    coreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AR Screen"
        ),
        centerTitle: true,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}
