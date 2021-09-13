// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors

import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:meu_filme/View/recomendar.dart';
import 'package:meu_filme/repositories/movies_repositories.dart';

final repositorie = repositories();

class homePrincipal extends StatefulWidget {
  @override
  State<homePrincipal> createState() {
    return homePrincipalState();
  }
}

class homePrincipalState extends State<homePrincipal> {
  int numberRandom = 0;
  String title = '';
  String people = '';
  String year = '';
  String overview = '';

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  void setRandom() async {
    var list = await repositorie.getRecommendations();
    var element = list[random(0, list.length)];
    setState(() {
      title = element.movie;
      people = element.people;
      year = element.year;
      overview = element.overview;
    });
    print(element.movie);

    // setState(() {
    //   list = help;
    // });
    // print(help);
  }

  void mandar() async {
    print('title');
    http.post(
      Uri.parse('https://meu-filme-5f43b-default-rtdb.firebaseio.com/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'titlezada',
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color(0xFF010028),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // ignore: prefer_const_constructors
                  margin: EdgeInsets.only(left: 20),
                  child: const Text(
                    'Veja agora uma otima recomendação de filme!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: SizedBox(
                    width: 200,
                    height: 80,
                    child: OutlinedButton(
                      child: const Text('Ver filme'),
                      style: OutlinedButton.styleFrom(
                        primary: Color(0xFF3C3B58),
                        backgroundColor: Colors.blueGrey[50],
                        shadowColor: Colors.black,
                        elevation: 10,
                        textStyle: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setRandom();
                        // list['-MjR2YbM65MU1shQSeD0']

                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  height: 350,
                                  color: Colors.white,
                                  child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                        Text(
                                          'Filme: ' + title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF010028),
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text('Recomendado por ' + people,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 15)),
                                        Text('Ano de lançamento ' + year,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 15,
                                            )),
                                        Text(overview,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 13,
                                            ))
                                      ])));
                            });
                      },
                    ),
                  ),
                ),
              ],
            )));
  }
}
