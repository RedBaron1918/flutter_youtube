import 'package:flutter/material.dart';

import '../module/module.dart';

class PlaylistStreamBuilder extends StatelessWidget {
  final Stream<VideosList> stream;
  final Widget Function(VideosList) builder;

  const PlaylistStreamBuilder({
    Key? key,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VideosList>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playlistData = snapshot.data!;
          return builder(playlistData);
        } else {
          return Container();
        }
      },
    );
  }
}
