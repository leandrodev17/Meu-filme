import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meu_filme/models/movies_models.dart';

class repositories {
  var url = Uri.https('api.themoviedb.org', '/3/movie/popular');
  var url2 =
      Uri.https('meu-filme-5f43b-default-rtdb.firebaseio.com', '/teste.json');

  Future<List<movies>?> fetchMovies() async {
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNmRiYmQ4YzJiZjQ3MzM0OTk3MjQ0NTRiOGI5ODg0ZCIsInN1YiI6IjYxM2NlOTBhOTY1M2Y2MDA5M2NjM2I2NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2K7bmJct6Bwvw1LOH0wHZ27jO-spxROB6_CaG4urQuk',
      },
    );

    if (response.statusCode != 200) return null;
    final data =
        List<Map<String, dynamic>>.from(json.decode(response.body)['results']);
    print(json.decode(response.body)['results']);
    return data.map((json) => movies.fromJson(json)).toList();
  }

  getRecommendations() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://meu-filme-5f43b-default-rtdb.firebaseio.com/teste.json'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();

      List<recommendation> dados = [];
      for (var entry in json.decode(data).entries) {
        final movie = recommendation.fromJson(entry.value);
        dados.add(movie);
      }

      return dados;
    } else {
      print(response.reasonPhrase);
    }

    // http.Response response = await http.get(Uri.https(
    //     'meu-filme-5f43b-default-rtdb.firebaseio.com', '/teste.json'));
    // // print(response.body);

    // if (response.statusCode != 200) return null;

    // final data = List<Map<String, dynamic>>.from(json.decode(response.body));

    // return data.map((json) => recommendation.recommendation(json)).toList();
  }

  // List<movies> dados = [];
  // for (var json in data) {
  //   final movie = movies.fromJson(json);
  //   dados.add(movie);
  // }

  // return dados;

  // Future<List<movies>> fetchMovies() async {
  //   final response = await dio.get(url);
  //   var data = response.data as List<Map<String, dynamic>>;
  //   final list = data;
  //   print(list);
  //   List<movies> dados = [];
  //   for (var json in list) {
  //     final movie = movies.fromJson(json);
  //     dados.add(movie);
  //   }
  //   return dados;
  // }
}

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }