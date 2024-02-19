import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Avatar Display'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // void onClick(){
  //   print('Model clicked! Switching to next screen...');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Column(
        children: [
          Expanded(
            flex: 1,
            child: ModelViewer(
              src: 'avatars/Astronaut.glb',
              autoRotate: true,
              ar: true,
              cameraControls: true,

            ),
          ),
          Expanded(
            flex: 2,
            child: ModelViewer(
              src: 'avatars/BusinessCard3D.glb',
              autoRotate: false,
              ar: true,
              cameraControls: true,
              disableZoom: false,
              interactionPrompt: InteractionPrompt.none,
            ),
          ),
        ],
      )
    );

    //return const Center(
    //     child: ModelViewer(
    //       src: 'avatars/BusinessCard3D.glb',
    //       autoRotate: false,
    //       ar: true,
    //       cameraControls: true,
    //     )
    //
    // ),
  }
}
