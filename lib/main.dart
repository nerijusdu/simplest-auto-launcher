import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplest_auto_launcher/pages/layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simplest app launcher',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        cardColor: const Color(0x802e363e),
        canvasColor: const Color(0xFF2e363e),
        scaffoldBackgroundColor: const Color(0xFF1F272D),
      ),
      home: const Layout(),
    );
  }
}
