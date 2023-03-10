import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertask2/pages/video_details_screen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'YouTube Playlist Stream',
      home: PlaylistScreen(),
    );
  }
}

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});
  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final playlistUrlController = TextEditingController();
  late Stream<Map<String, dynamic>> playlistDataStream;
  late String playlistTitle = "";

  @override
  void initState() {
    super.initState();
    playlistDataStream = createPlaylistDataStream(
        'https://www.youtube.com/playlist?list=PLqAfPOrmacr963ATEroh67fbvjmTzTEx5');
  }

  @override
  void dispose() {
    playlistUrlController.dispose();
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
        print(e);
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
              return ListWidget(
                playlistTitle: playlistTitle,
                playlistData: playlistData,
              );
            } else {
              print(snapshot);
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

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.playlistTitle,
    required this.playlistData,
  });

  final String playlistTitle;
  final Map<String, dynamic> playlistData;

  @override
  Widget build(BuildContext context) {
    final test = playlistData["items"][0]["video"];
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Playlist title: $playlistTitle'),
          const SizedBox(height: 16.0),
          Text('Number of videos: ${playlistData['items'].length}'),
          const SizedBox(height: 16.0),
          Container(
            height:
                MediaQuery.of(context).size.height, // adjust height as needed
            child: ListView.builder(
              itemCount: playlistData['items'].length,
              itemBuilder: (context, index) {
                final video = playlistData['items'][index]['snippet'];
                return Container(
                  width: 100,
                  height: 100,
                  child: ListTile(
                    title: Text(video['title']),
                    leading:
                        Image.network(video['thumbnails']['default']['url']),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoDetailsScreen(
                              videoData: playlistData['items'][index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
