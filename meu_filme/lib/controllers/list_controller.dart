import 'package:flutter/cupertino.dart';
import 'package:meu_filme/models/movies_models.dart';
import 'package:meu_filme/repositories/movies_repositories.dart';

class listController {
  List<movies> moviesAndSeries = [];
  final repositorie = repositories();

  final state = ValueNotifier<homeState>(homeState.start);

  Future start() async {
    state.value = homeState.loading;
    try {
      moviesAndSeries = (await repositorie.fetchMovies())!;
      state.value = homeState.success;
    } catch (e) {
      print(e);
      state.value = homeState.error;
    }
  }
}

enum homeState { start, loading, success, error }
