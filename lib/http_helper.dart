import 'package:http/http.dart' as http;
import 'dart:io';
import 'http_helper.dart';
import 'movie.dart';
import 'dart:convert';

class HttpHelper {
  final String urlKey = 'api_key=17abd244c318039834dbf6ab1d0b85f4';
  final String urlBase = 'https://api.themoviedb.org/3/movies_app';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=[17abd244c318039834dbf6ab1d0b85f4]&query=';

  // Future<List> getUpcoming() async {
  //   final Uri upcomingUri =
  //       Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

  //   http.Response result = await http.get(upcomingUri);
  //   print("result: ${result}");

  //   try {
  //     if (result.statusCode == HttpStatus.ok) {
  //       final jsonResponse = json.decode(result.body);
  //       final moviesMap = jsonResponse['results'];
  //       List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
  //       return movies;
  //     } else {
  //       throw Exception(
  //           'HTTP request failed with status code ${result.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error getting upcoming events: $e');
  //     return [];
  //   }
  // }
  Future<List> getUpcoming() async {
    final Uri upcomingUri =
        Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

    final http.Response result = await http.get(upcomingUri);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      return moviesMap.map((i) => Movie.fromJson(i)).toList();
    } else {
      throw Exception(
          'HTTP request failed with status code ${result.statusCode}');
    }
  }

  Future<List<Movie>> findMovies(String title) async {
    const String urlKey = '17abd244c318039834dbf6ab1d0b85f4';
    const String urlBase = 'https://api.themoviedb.org/3/search/movies_app';

    try {
      final String query = '$urlBase?api_key=$urlKey&query=$title';
      final http.Response result = await http.get(Uri.parse(query));

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final moviesMap = jsonResponse['results'];
        return moviesMap.map((i) => Movie.fromJson(i)).toList();
      } else {
        throw Exception(
            'HTTP request failed with status code ${result.statusCode}');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
