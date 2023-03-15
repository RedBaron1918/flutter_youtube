import 'dart:io';

import 'package:fluttertask2/consts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../module/module.dart';

class Services {
  static const CHANNEL_ID = 'PLpyiw5uEqZ9tfguPsVZoLCFHP7ybPHx47';
  static const _baseUrl = 'www.googleapis.com';

  static Future<VideosList> getVideosList() async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': CHANNEL_ID,
      'maxResults': '8',
      'key': Constants.API_KEY,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Response response = await http.get(uri, headers: headers);
    // print(response.body);
    VideosList videosList = videosListFromJson(response.body);
    return videosList;
  }
}
