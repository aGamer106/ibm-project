// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class TextToSpeechPage extends StatelessWidget {
//   const TextToSpeechPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   FlutterTts flutterTts = FlutterTts();
//   TextEditingController controller = TextEditingController();
//
//   double volume = 1.0;
//   double pitch = 1.0;
//   double speechRate = 0.5;
//   List<String>? languages;
//   String langCode = "en-US";
//   bool isSpeaking = false;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   void init() async {
//     // SharedPreferences prefs = await SharedPreferences.getInstance();
//     volume = prefs.getDouble('volume') ?? 1.0;
//     pitch = prefs.getDouble('pitch') ?? 1.0;
//     speechRate = prefs.getDouble('speechRate') ?? 0.5;
//     langCode = prefs.getString('langCode') ?? "en-US";
//     languages = List<String>.from(await flutterTts.getLanguages);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text("Text To Speech"),
//         ),
//         body: Container(
//           margin: const EdgeInsets.only(top: 20),
//           child: Center(
//             child: Column(children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     width: 200,
//                     height: 60,
//                     child: TextField(
//                       controller: controller,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         hintText: 'Enter Text',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: _speak,
//                     child: const Text("Speak"),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   ElevatedButton(
//                     onPressed: _stop,
//                     child: const Text("Stop"),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 80,
//                       child: Text(
//                         "Volume",
//                         style: TextStyle(fontSize: 17),
//                       ),
//                     ),
//                     Slider(
//                       min: 0.0,
//                       max: 1.0,
//                       value: volume,
//                       onChanged: (value) {
//                         setState(() {
//                           volume = value;
//                         });
//                       },
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       child: Text(
//                           double.parse((volume).toStringAsFixed(2)).toString(),
//                           style: const TextStyle(fontSize: 17)),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 80,
//                       child: Text(
//                         "Pitch",
//                         style: TextStyle(fontSize: 17),
//                       ),
//                     ),
//                     Slider(
//                       min: 0.5,
//                       max: 2.0,
//                       value: pitch,
//                       onChanged: (value) {
//                         setState(() {
//                           pitch = value;
//                         });
//                       },
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       child: Text(
//                           double.parse((pitch).toStringAsFixed(2)).toString(),
//                           style: const TextStyle(fontSize: 17)),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 10),
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 80,
//                       child: Text(
//                         "Speech Rate",
//                         style: TextStyle(fontSize: 17),
//                       ),
//                     ),
//                     Slider(
//                       min: 0.0,
//                       max: 1.0,
//                       value: speechRate,
//                       onChanged: (value) {
//                         setState(() {
//                           speechRate = value;
//                         });
//                       },
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 10),
//                       child: Text(
//                           double.parse((speechRate).toStringAsFixed(2))
//                               .toString(),
//                           style: const TextStyle(fontSize: 17)),
//                     )
//                   ],
//                 ),
//               ),
//               if (languages != null)
//                 Container(
//                   margin: const EdgeInsets.only(left: 10),
//                   child: Row(
//                     children: [
//                       const Text(
//                         "Language :",
//                         style: TextStyle(fontSize: 17),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       DropdownButton<String>(
//                         focusColor: Colors.white,
//                         value: langCode,
//                         style: const TextStyle(color: Colors.white),
//                         iconEnabledColor: Colors.black,
//                         items: languages!
//                             .map<DropdownMenuItem<String>>((String? value) {
//                           return DropdownMenuItem<String>(
//                             value: value!,
//                             child: Text(
//                               value,
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? value) {
//                           setState(() {
//                             langCode = value!;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 )
//             ]),
//           ),
//         ));
//   }
//
//   void initSetting() async {
//     await flutterTts.setVolume(volume);
//     await flutterTts.setPitch(pitch);
//     await flutterTts.setSpeechRate(speechRate);
//     await flutterTts.setLanguage(langCode);
//   }
//
//   void saveSettings() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setDouble('volume', volume);
//     await prefs.setDouble('pitch', pitch);
//     await prefs.setDouble('speechRate', speechRate);
//     await prefs.setString('langCode', langCode);
//   }
//
//   void _speak() async {
//     try {
//       initSetting();
//       await flutterTts.speak(controller.text);
//       setState(() {
//         isSpeaking = true;
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error in _speak: $e");
//       }
//     }
//   }
//
//   //TODO: Connect Watson API
//
//   /*
//   void _speak() async {
//   try {
//     initSetting();
//     var response = await watsonApi.textToSpeech(controller.text);
//     if (response.statusCode == 200) {
//       // Save the audio file
//       var tempDir = await getTemporaryDirectory();
//       var filePath = '${tempDir.path}/speech.mp3';
//       await File(filePath).writeAsBytes(response.bodyBytes);
//
//       // Play the audio file
//       await audioPlayer.play(filePath, isLocal: true);
//     }
//     setState(() {
//       isSpeaking = true;
//     });
//   } catch (e) {
//     if (kDebugMode) {
//       print("Error in _speak: $e");
//     }
//   }
// }
//    */
//
//   void _stop() async {
//     try {
//       await flutterTts.stop();
//       setState(() {
//         isSpeaking = false;
//       });
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error in _stop: $e");
//       }
//     }
//   }
// }