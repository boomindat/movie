import 'package:http/http.dart' as http;
import 'dart:io';
import 'http_helper.dart';
import 'movie.dart';
import 'dart:convert';

class HttpHelper {
  final String urlKey = 'api_key=17abd244c318039834dbf6ab1d0b85f4';
  final String urlBase = 'https://api.themoviedb.org/3/discover/movie?';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie550?api_key=[17abd244c318039834dbf6ab1d0b85f4]&query=';

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
    final headers = {
      "Authorization":
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTU0NGJlYTVhZjQ4ZTNmY2Y3MDk3MmNmYmNjNDU5MiIsInN1YiI6IjY0NmQyM2YwMzNhMzc2MDE1OGRiYTM4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3Ri0V8rPdsy3lCgLnBm6gB4G35jcPpPzdKlvn4VxeVw'
    };
    final Uri upcomingUri =
        Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

    final http.Response result = await http.get(upcomingUri, headers: headers);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      return moviesMap.map((i) => Movie.fromJson(i)).toList();
    } else {
      throw Exception(
          'HTTP request failed with status code ${result.statusCode}');
    }
  }

  Future<List> findMovies(String title) async {
    const String urlKey = '17abd244c318039834dbf6ab1d0b85f4';
    const String urlBase = 'https://api.themoviedb.org/3/search/movie';

    try {
      final String query =
          '$urlBase?api_key=$urlKey&query=$title&language=en-US&page=1';
      final headers = {
        "Authorization":
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOTU0NGJlYTVhZjQ4ZTNmY2Y3MDk3MmNmYmNjNDU5MiIsInN1YiI6IjY0NmQyM2YwMzNhMzc2MDE1OGRiYTM4YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3Ri0V8rPdsy3lCgLnBm6gB4G35jcPpPzdKlvn4VxeVw'
      };
      final http.Response result =
          await http.get(Uri.parse(query), headers: headers);

      if (result.statusCode == HttpStatus.ok) {
        final jsonResponse = json.decode(result.body);
        final moviesMap = jsonResponse['results'];
        // print("movies :${moviesMap}");
        // var resultt = moviesMap.map((i) => Movie.fromJson(i)).toList();
        // print("finished ${result}");
        return moviesMap.map((i) => Movie.fromJson(i)).toList();
      } else {
        throw Exception(
            'HTTP request failed with status code ${result.statusCode}');
      }
    } catch (e) {
      // print(e);
      return [];
    }
  }
}
