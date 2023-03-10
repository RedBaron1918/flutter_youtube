import 'package:flutter/material.dart';
import 'package:fluttertask2/pages/video_details_screen.dart';

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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Playlist title: $playlistTitle'),
          const SizedBox(height: 16.0),
          Text('Number of videos: ${playlistData['items'].length}'),
          const SizedBox(height: 16.0),
          SizedBox(
            height:
                MediaQuery.of(context).size.height, // adjust height as needed
            child: ListView.builder(
              itemCount: playlistData['items'].length,
              itemBuilder: (context, index) {
                final video = playlistData['items'][index]['snippet'];
                return SizedBox(
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
