import 'package:AlkoApp/views/AgeView.dart';
import 'package:AlkoApp/views/DrinkView.dart';
import 'package:AlkoApp/views/MyDrinksView.dart';
import 'package:AlkoApp/views/MyFavoritesView.dart';
import 'package:AlkoApp/views/StartView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:AlkoApp/views/MySearchView.dart';
import 'package:AlkoApp/model/Model.dart';




void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Model(), builder: (context, child) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => AgeView(),
        '/StartView': (context) => StartView(), 
        '/DrinkView': (context) => DrinkView(),
        '/MySearchView': (context) => MySearchView(),
        '/MyFavoritesView': (context) => MyFavoritesView(),
        '/MyDrinksView': (context) => MyDrinksView(),
      },
    );
  }
}
