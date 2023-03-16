import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertask2/consts.dart';

import '../module/module.dart';

final Map<String, VideosList> _cachedResponses = {};

class Services {
  static Future<VideosList> fetchPlaylistData(String playlistUrl) async {
    if (_cachedResponses.containsKey(playlistUrl)) {
      print(playlistUrl);
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
      print(videosList);
      return videosList;
    } else {
      throw Exception('Failed to fetch playlist data');
    }
  }
}
