import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:meu_filme/models/movies_models.dart';
import 'package:meu_filme/repositories/movies_repositories.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class firebaseController extends ChangeNotifier {
  // String movie = '';
  // String people = '';
  // String year = '';

  final repositorie = repositories();

  Future saveRec(movie, people, year, overview) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://meu-filme-5f43b-default-rtdb.firebaseio.com/teste.json'));
    request.body = json.encode(
        {"movie": movie, "people": people, "year": year, "overview": overview});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    // WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp();

    // FirebaseFirestore.instance
    //     .collection('filmes')
    //     .add({'title': movie, 'people': people, 'year': year})
    //     .then((value) => "Mais um minion adicionado à família")
    //     .catchError((error) =>
    //         "Parece que teve problemas com o último minion:\n $error");
  }
}
