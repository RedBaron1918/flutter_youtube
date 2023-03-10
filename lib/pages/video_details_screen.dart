import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;

  const VideoDetailsScreen({Key? key, required this.videoData})
      : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final video = widget.videoData['snippet'];
    return Scaffold(
      appBar: AppBar(
        title: Text(video['title']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(video['thumbnails']['high']['url']),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video['title'],
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  video['description'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
