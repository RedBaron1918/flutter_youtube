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
  late bool caption;
  late bool _isThumbsUpPressed;
  late bool _isThumbsDownPressed;
  @override
  void initState() {
    super.initState();
    _isThumbsUpPressed = false;
    _isThumbsDownPressed = false;
    caption = false;
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
        enableCaption: false,
        loop: true,
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
  void deactivate() {
    _controller.pause();
    super.deactivate();
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
  void changeCaption(bool switching) {
    _controller.flags.copyWith(enableCaption: switching);
  }

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
              progressColors: const ProgressBarColors(
                backgroundColor: Colors.grey,
                playedColor: Colors.red,
                handleColor: Colors.white,
              ),
              liveUIColor: Colors.black,
              topActions: [
                Expanded(
                  child: Text(
                    video?.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.closed_caption_off,
                        color: caption ? Colors.white : Colors.grey,
                        size: 25.0,
                      ),
                      onPressed: () {
                        setState(() {
                          caption = !caption;
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
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
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                video?.thumbnails?.thumbnailsDefault?.url ??
                                    ''),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(video?.channelTitle ?? '')
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Subscribe'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 39, 39, 39),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isThumbsUpPressed = !_isThumbsUpPressed;
                                    if (_isThumbsUpPressed) {
                                      _isThumbsDownPressed = false;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: _isThumbsUpPressed
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 20),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isThumbsDownPressed =
                                        !_isThumbsDownPressed;
                                    if (_isThumbsDownPressed) {
                                      _isThumbsUpPressed = false;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.thumb_down_alt_outlined,
                                  color: _isThumbsDownPressed
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.shortcut_rounded),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 39, 39),
                              shape: const StadiumBorder(),
                            ),
                            label: const Text("share"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add_to_photos_outlined),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 39, 39),
                              shape: const StadiumBorder(),
                            ),
                            label: const Text("Save"),
                          ),
                        ],
                      )
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
