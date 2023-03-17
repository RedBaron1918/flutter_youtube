import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertask2/consts.dart';

import '../module/module.dart';

final Map<String, VideosList> _cachedResponses = {};

class Services {
  static Future<VideosList> fetchPlaylistData(String playlistUrl) async {
    if (_cachedResponses.containsKey(playlistUrl)) {
      return Future.value(_cachedResponses[playlistUrl]!);
    }
    final playlistId = playlistUrl.split('?list=')[1];
    final apiUrl = 'https://www.googleapis.com/youtube/v3/playlistItems?'
        'part=snippet&maxResults=50&playlistId=$playlistId&key=${Constants.API_KEY}';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      final videosList = VideosList.fromJson(decodedResponse);
      _cachedResponses[playlistUrl] = videosList;
      return videosList;
    } else {
      throw Exception('Failed to fetch playlist data');
    }
  }

  static Stream<VideosList> createPlaylistDataStream(
      String playlistUrl) async* {
    while (true) {
      try {
        final playlistData = await Services.fetchPlaylistData(playlistUrl);
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
}
