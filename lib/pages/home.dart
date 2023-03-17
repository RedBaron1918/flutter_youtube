import 'package:flutter/material.dart';
import 'package:fluttertask2/utils/services.dart';
import 'package:fluttertask2/widgets/list_info.dart';
import 'package:fluttertask2/widgets/play_list_stream.dart';
import 'dart:async';
import '../module/module.dart';
import '../widgets/list_widget.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Stream<VideosList> playlistDataStream;
  late String playlistTitle = "";

  @override
  void initState() {
    super.initState();
    playlistDataStream = Services.createPlaylistDataStream(
        'https://www.youtube.com/playlist?list=PLpyiw5uEqZ9tfguPsVZoLCFHP7ybPHx47');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Playlist'),
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        actions: [
          IconButton(
            icon: const Icon(Icons.screen_share_outlined),
            splashRadius: 20,
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.search),
            splashRadius: 20,
            onPressed: () {},
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            splashRadius: 20,
            onPressed: () {},
          ),
        ],
      ),
      body: PlaylistStreamBuilder(
        stream: playlistDataStream,
        builder: (playlistData) {
          if (playlistData.videos != null) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListInfo(
                    data: playlistData.videos!.length,
                    imgUrl:
                        playlistData.videos?[0].video?.thumbnails?.high?.url ??
                            '',
                  ),
                  ListWidget(
                    playlistData: playlistData,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Playlist data is not available.'),
            );
          }
        },
      ),
    );
  }
}
