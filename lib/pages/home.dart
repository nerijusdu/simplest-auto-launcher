import 'dart:developer';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplest_auto_launcher/widgets/audio_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ApplicationWithIcon> apps = [];

  @override
  void initState() {
    getFavoriteApps();
    super.initState();
  }

  Future getFavoriteApps() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteApps = prefs.getStringList('favoriteApps') ?? [];
    final apps =
        await Future.wait(favoriteApps.map((x) => DeviceApps.getApp(x, true)));
    setState(() {
      this.apps =
          apps.where((x) => x != null).cast<ApplicationWithIcon>().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: apps
                  .map((e) => IconButton(
                        onPressed: () {
                          DeviceApps.openApp(e.packageName);
                        },
                        iconSize: 50,
                        icon: Image.memory(e.icon),
                      ))
                  .toList(),
            ),
          ),
        ),
        const Expanded(
          child: Card(child: AudioPlayer()),
        ),
      ],
    );
  }
}
