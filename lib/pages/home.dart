import 'package:flutter/material.dart';
import 'package:simplest_auto_launcher/widgets/audio_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: MediaQuery.of(context).size.height - 100,
      child: const AudioPlayer(),
    );
  }
}
