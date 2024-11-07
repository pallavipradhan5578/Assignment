import 'package:assignment/providers/movie_provider.dart';
import 'package:assignment/ui/movie_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MoviePage(),debugShowCheckedModeBanner: false,
    );
  }
}
