import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final Map<String, dynamic> _cachedResponses = {};

Future<Map<String, dynamic>> fetchPlaylistData(String playlistUrl) async {
  if (_cachedResponses.containsKey(playlistUrl)) {
    print(playlistUrl +
        "hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
    return _cachedResponses[playlistUrl];
  }

  const apiKey = 'AIzaSyDF24QdFRwrMg0OXJT3fBObRuOD9h2WOwU';
  final playlistId = playlistUrl.split('?list=')[1];
  final apiUrl = 'https://www.googleapis.com/youtube/v3/playlistItems?'
      'part=snippet&maxResults=50&playlistId=$playlistId&key=$apiKey';
  final response = await http.get(Uri.parse(apiUrl));
  if (response.statusCode == 200) {
    print("asfihauisfhiasudhiusdhuhsdifhsidfhsidfhisudhfisdhfishdufisdfsdf");
    final decodedResponse = jsonDecode(response.body);
    _cachedResponses[playlistUrl] = decodedResponse;
    return decodedResponse;
  } else {
    throw Exception('Failed to fetch playlist data');
  }
}
