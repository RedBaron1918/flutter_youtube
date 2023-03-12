import 'package:flutter/material.dart';
import 'package:fluttertask2/pages/video_details_screen.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.playlistData,
  });

  final Map<String, dynamic> playlistData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlistData['items'].length,
      itemBuilder: (context, index) {
        final video = playlistData['items'][index]['snippet'];
        return SizedBox(
          width: 100,
          height: 100,
          child: ListTile(
            title: Text(
              video['title'],
            ),
            subtitle: Text(video['videoOwnerChannelTitle']),
            leading: Image.network(
              video['thumbnails']['default']['url'],
            ),
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
    );
  }
}
