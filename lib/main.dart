import 'package:flutter/material.dart';
import 'package:simplest_auto_launcher/pages/layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
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
      ),
      home: const Layout(),
    );
  }
}
