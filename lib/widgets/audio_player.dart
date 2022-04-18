import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({Key? key}) : super(key: key);

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  bool isPlaying = false;

  @override
  void initState() {
    initSpotify();
    super.initState();
  }

  void initSpotify() async {
    await SpotifySdk.connectToSpotifyRemote(
      clientId: dotenv.env['SPOTIFY_CLIENT_ID'] ??
          (throw Exception('SPOTIFY_CLIENT_ID is not defined')),
      redirectUrl: "simplest-auto-launcher://callback",
    );
    var isActive = await SpotifySdk.isSpotifyAppActive;
    var state = await SpotifySdk.getPlayerState();
    setState(() {
      isPlaying = isActive && (state == null || !state.isPaused);
    });
  }

  void nextSong() async {
    await SpotifySdk.skipNext();
  }

  void prevSong() async {
    await SpotifySdk.skipPrevious();
  }

  void playPause() async {
    if (isPlaying) {
      await SpotifySdk.pause();
    } else {
      await SpotifySdk.resume();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: prevSong,
          alignment: Alignment.center,
          iconSize: 50,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        IconButton(
          onPressed: playPause,
          alignment: Alignment.center,
          iconSize: 50,
          icon: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        ),
        IconButton(
          onPressed: nextSong,
          alignment: Alignment.center,
          iconSize: 50,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
