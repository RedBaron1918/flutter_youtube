import 'package:flutter/material.dart';
import 'package:fluttertask2/module/module.dart';

import '../pages/video_details_screen.dart';

class ListBig extends StatefulWidget {
  const ListBig({
    super.key,
    required this.playlistData,
    // required this.changeVideo,
  });

  final VideosList playlistData;
  //final Function changeVideo;
  @override
  State<ListBig> createState() => _ListBigState();
}

class _ListBigState extends State<ListBig> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.playlistData.videos?.length,
      itemBuilder: (context, index) {
        final video = widget.playlistData.videos![index].video;
        return InkWell(
          onTap: () {
            // widget.changeVideo(widget.playlistData['items'][index]['snippet']
            //     ['resourceId']['videoId']);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => VideoDetailsScreen(
                  videoData: widget.playlistData.videos![index],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        video?.thumbnails?.high?.url ?? '',
                      ),
                    ),
                    Text(video?.title ?? ''),
                    Text(
                      video?.channelTitle ?? '',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
