// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:meu_filme/controllers/firebase_controller.dart';
import 'package:meu_filme/main.dart';
import 'package:meu_filme/repositories/movies_repositories.dart';

class recommendation {
  String movie;
  String overview;
  String people;
  String year;

  recommendation(
      {required this.movie,
      required this.overview,
      required this.people,
      required this.year});

  factory recommendation.fromJson(Map<String, dynamic> json) {
    return recommendation(
        movie: json['movie'],
        overview: json['overview'],
        people: json['people'],
        year: json['year']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie'] = this.movie;
    data['overview'] = this.overview;
    data['people'] = this.people;
    data['year'] = this.year;
    return data;
  }
}

void main() {
  final repositorie = repositories();

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  test('teste', () async {
    final list = await repositorie.getRecommendations();
    print(list[0].movie);
  });
}
