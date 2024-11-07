import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List movieList = [];
  bool isRequesting = false;

  Future<void> getUserApi({String query = 'latest'}) async {
    isRequesting = true;
    notifyListeners();

    final response = await http.get(
        Uri.parse('https://www.omdbapi.com/?apikey=52858e96&s=$query&type=movie'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      // Corrected the condition to check if the response is "True"
      if (data['Response'] == "True") {
        movieList = data['Search'];
      } else {
        movieList = [];
      }
    } else {
      movieList = [];
    }

    isRequesting = false;
    notifyListeners();
  }
}
