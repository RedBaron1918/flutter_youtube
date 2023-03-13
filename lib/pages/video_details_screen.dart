import 'package:flutter/material.dart';
import 'package:fluttertask2/widgets/list_big.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:fluttertask2/utils/fetch.dart';

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
  late Stream<Map<String, dynamic>> playlistDataStream;
  bool _isExpanded = false;
  String _descriptionShort = "";
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String playlistTitle = "";

  @override
  void initState() {
    super.initState();
    String description = widget.videoData['snippet']['description'];
    _descriptionShort = description.length >= 100
        ? "${description.substring(0, 100)}..."
        : description;

    isReady = false;
    playlistDataStream = createPlaylistDataStream(
        'https://www.youtube.com/playlist?list=PLpyiw5uEqZ9tfguPsVZoLCFHP7ybPHx47');
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoData['snippet']['resourceId']['videoId'],
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
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

  void changeVideo(String videoId) {
    // setState(() {
    _controller.load(videoId);
    // });
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
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: _toggleExpand,
                    child: SizedBox(
                      height: _isExpanded ? null : 40.0,
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
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.thumb_up_alt_outlined),
                            label: const Text(""),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text(""),
                            icon: const Icon(Icons.thumb_down_alt_outlined),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 39, 39),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.shortcut_sharp),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        label: const Text("share"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder<Map<String, dynamic>>(
              stream: playlistDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playlistData = snapshot.data!;
                  if (playlistData.containsKey('items')) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListBig(
                            playlistData: playlistData,
                            changeVideo: changeVideo,
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
          ],
        ),
      ),
    );
  }
}
