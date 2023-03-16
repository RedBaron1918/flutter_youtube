import 'package:flutter/material.dart';
import 'package:fluttertask2/utils/services.dart';
import 'package:fluttertask2/widgets/list_info.dart';
import 'dart:async';
import '../widgets/list_widget.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late Stream<Map<String, dynamic>> playlistDataStream;
  late String playlistTitle = "";

  @override
  void initState() {
    super.initState();
    playlistDataStream = createPlaylistDataStream(
        'https://www.youtube.com/playlist?list=PLpyiw5uEqZ9tfguPsVZoLCFHP7ybPHx47');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<Map<String, dynamic>> createPlaylistDataStream(
      String playlistUrl) async* {
    while (true) {
      try {
        final playlistData = await Services.fetchPlaylistData(playlistUrl);
        yield playlistData;
      } catch (e) {
        yield {};
      }
      await Future.delayed(
        const Duration(minutes: 2),
      );
    }
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
      body: StreamBuilder<Map<String, dynamic>>(
        stream: playlistDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final playlistData = snapshot.data!;
            if (playlistData.containsKey('items')) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListInfo(
                      data: playlistData['items'].length,
                      imgUrl: playlistData['items'][0]['snippet']['thumbnails']
                          ['high']['url'],
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
