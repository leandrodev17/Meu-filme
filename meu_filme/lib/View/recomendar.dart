import 'package:flutter/material.dart';
import 'package:meu_filme/controllers/firebase_controller.dart';
import 'package:meu_filme/controllers/list_controller.dart';
import 'package:meu_filme/models/movies_models.dart';
import 'package:meu_filme/repositories/movies_repositories.dart';

final _db = firebaseController();
final controller = listController();

class recomendar extends StatefulWidget {
  @override
  State<recomendar> createState() {
    return recomendarState();
  }
}

class recomendarState extends State<recomendar> {
  String movie = '';
  String people = '';
  String year = '';
  String overview = '';

  void sand() async {
    if (movie != '' || people != '' || year != '' || overview != '') {
      await _db.saveRec(movie, people, year, overview);
      // showAlertDialog1(context);
    }
  }

  _success() {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          child: const Text(
            'Escreva um filme para recomendar!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 30),
            child: Autocomplete<movies>(
              displayStringForOption: (option) => option.title,
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldTextEditingController,
                  FocusNode fieldFocusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3C3B58)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3C3B58)),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF3C3B58)),
                      )),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) {
                return controller.moviesAndSeries.where((movies option) =>
                    option.originalTitle
                        .toLowerCase()
                        .startsWith(textEditingValue.text.toLowerCase()));
              },
              onSelected: (movies selection) {
                setState(() {
                  movie = selection.title;
                  people = 'Leandro';
                  year = selection.releaseDate;
                  overview = selection.overview;
                });

                // sand(selection.title, 'leandro', selection.releaseDate,
                //     selection.overview);
              },
            )),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: SizedBox(
            width: 200,
            height: 40,
            child: OutlinedButton(
              child: const Text('Recomendar'),
              style: OutlinedButton.styleFrom(
                primary: Color(0xFF3C3B58),
                backgroundColor: Colors.blueGrey[50],
                shadowColor: Colors.black,
                elevation: 10,
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                sand();
              },
            ),
          ),
        ),
      ]),
    ); // Text(controller.moviesAndSeries[0].title);
  }

  _error() {
    return Text(
      'Algo deu errado',
    );
  }

  _loading() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3C3B58)),
    );
  }

  _start() {
    return Container();
  }

  stateManagement(homeState state) {
    switch (state) {
      case homeState.start:
        return _start();
      case homeState.loading:
        return _loading();
      case homeState.error:
        return _error();
      case homeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.start();
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
                    child: AnimatedBuilder(
                  animation: controller.state,
                  builder: (context, child) {
                    return stateManagement(controller.state.value);
                  },
                )),
              ],
            )));
  }
}
