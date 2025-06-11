import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ExamplePage()));
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          AudioPlayer audioPlayer = AudioPlayer();

          audioPlayer.play(AssetSource('Ancestral.mp3'));
        }, child: const Text('Play')),
      ),
    );
  }
}
