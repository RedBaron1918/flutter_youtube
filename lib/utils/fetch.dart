import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Map<String, dynamic>> fetchPlaylistData(String playlistUrl) async {
  const apiKey = 'AIzaSyDF24QdFRwrMg0OXJT3fBObRuOD9h2WOwU';
  final playlistId = playlistUrl.split('?list=')[1];
  final apiUrl = 'https://www.googleapis.com/youtube/v3/playlistItems?'
      'part=snippet&maxResults=50&playlistId=$playlistId&key=$apiKey';
  final response = await http.get(Uri.parse(apiUrl));
  print(apiUrl);
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch playlist data');
  }
}
