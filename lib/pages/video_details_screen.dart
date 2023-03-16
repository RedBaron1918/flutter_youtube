import 'package:flutter/material.dart';
import 'package:fluttertask2/widgets/list_big.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../module/module.dart';
import '../utils/services.dart';

class VideoDetailsScreen extends StatefulWidget {
  final VideoItem videoData;

  const VideoDetailsScreen({Key? key, required this.videoData})
      : super(key: key);

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen>
    with TickerProviderStateMixin {
  late YoutubePlayerController _controller;
  late bool isReady;
  late Stream<VideosList> playlistDataStream;

  bool _isExpanded = false;
  String _descriptionShort = "";
  late AnimationController _animationController;
  late Animation<double> _animation;
  late String playlistTitle = "";

  @override
  void initState() {
    super.initState();
    String description = widget.videoData.video?.description ?? '';
    _descriptionShort = description.length >= 100
        ? "${description.substring(0, 100)}..."
        : description;

    isReady = false;
    playlistDataStream = createPlaylistDataStream(
        'https://www.youtube.com/playlist?list=PLpyiw5uEqZ9tfguPsVZoLCFHP7ybPHx47');
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoData.video?.resourceId?.videoId ?? '',
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

  Stream<VideosList> createPlaylistDataStream(String playlistUrl) async* {
    while (true) {
      try {
        final playlistData = await Services.fetchPlaylistData(playlistUrl);
        playlistTitle = playlistData.videos![0].video!.channelTitle!;
        yield playlistData;
      } catch (e) {
        yield VideosList(
          kind: '',
          etag: '',
          nextPageToken: null,
          videos: [],
          pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0),
        );
      }
      await Future.delayed(const Duration(minutes: 2));
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

  // void changeVideo(String videoId) {
  // _controller.load(videoId);
  //}

  @override
  Widget build(BuildContext context) {
    final video = widget.videoData.video;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 37, 37),
        title: Text(
          video?.title ?? '',
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
                    video?.title ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: _toggleExpand,
                    child: SizedBox(
                      height: _isExpanded ? null : 40.0,
                      child: Text(
                        _isExpanded
                            ? video?.description ?? ''
                            : _descriptionShort,
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
                        video?.description ?? '',
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
            StreamBuilder<VideosList>(
              stream: playlistDataStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playlistData = snapshot.data!;
                  if (playlistData.videos != null) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListBig(
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
          ],
        ),
      ),
    );
  }
}
