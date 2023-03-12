import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Playlist',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 26, 26, 26),
          textTheme: Typography.whiteRedmond),
      home: const PlaylistScreen(),
    );
  }
}
