import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> videoData;

  const VideoDetailsScreen({Key? key, required this.videoData})
      : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late bool isReady;
  bool _isExpanded = false;
  String _descriptionShort = "";
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    String description = widget.videoData['snippet']['description'];
    _descriptionShort = description.length >= 100
        ? "${description.substring(0, 100)}..."
        : description;

    isReady = false;
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoData['snippet']['resourceId']['videoId'],
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.videoData['snippet'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        title: Text(
          video['title'],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => isReady = true,
            ),
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
                  GestureDetector(
                    onTap: _toggleExpand,
                    child: Container(
                      height: _isExpanded ? null : 100.0,
                      child: Text(
                        _isExpanded ? video['description'] : _descriptionShort,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Visibility(
                    visible: _isExpanded,
                    child: FadeTransition(
                      opacity: _animation,
                      child: Text(
                        video['description'],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
