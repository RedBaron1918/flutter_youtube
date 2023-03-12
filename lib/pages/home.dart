import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
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

  Future<Map<String, dynamic>> fetchPlaylistData(String playlistUrl) async {
    const apiKey = 'AIzaSyDF24QdFRwrMg0OXJT3fBObRuOD9h2WOwU';
    final playlistId = playlistUrl.split('?list=')[1];
    final apiUrl = 'https://www.googleapis.com/youtube/v3/playlistItems?'
        'part=snippet&maxResults=50&playlistId=$playlistId&key=$apiKey';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch playlist data');
    }
  }

  Stream<Map<String, dynamic>> createPlaylistDataStream(
      String playlistUrl) async* {
    while (true) {
      try {
        final playlistData = await fetchPlaylistData(playlistUrl);
        playlistTitle = playlistData['items'][0]['snippet']['channelTitle'];
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
        title: const Text('YouTube Playlist Stream'),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: playlistDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final playlistData = snapshot.data!;
            if (playlistData.containsKey('items')) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      playlistData['items'][0]['snippet']['thumbnails']['high']
                          ['url'],
                    ),
                    ListWidget(
                      playlistTitle: playlistTitle,
                      playlistData: playlistData,
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                  child: Text('Playlist data is not available.'));
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
