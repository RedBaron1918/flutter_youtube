import 'package:flutter/material.dart';
import 'package:fluttertask2/module/module.dart';
import 'package:fluttertask2/pages/video_details_screen.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
    required this.playlistData,
  });

  final VideosList playlistData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlistData.videos?.length,
      itemBuilder: (context, index) {
        final video = playlistData.videos?[index].video;
        return SizedBox(
          width: 100,
          height: 100,
          child: ListTile(
            title: Text(
              video?.title ?? '',
            ),
            subtitle: Text(video?.channelTitle ?? ''),
            leading: Image.network(
              video?.thumbnails?.thumbnailsDefault?.url ?? '',
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoDetailsScreen(
                    videoData: playlistData.videos![index],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
