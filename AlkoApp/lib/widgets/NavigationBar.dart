import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:AlkoApp/objects/NavigationBarObject.dart';


class CustomNavigationBar extends StatelessWidget {
  final Color _mainColor = Colors.white;

  Widget build(BuildContext context) {
    return Container(
      //Android eller iPhone
      height: Platform.isAndroid
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.11,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, -10.0),
            blurRadius: 20.0,
          ),
        ],
        color: _mainColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: NavigationBarObject(
                  item: 0,
                  route: '/StartView',
                  title: "Inspiration",
                  iconItem: Icons.lightbulb_outline),
            ),
            Expanded(
              flex: 1,
              child: NavigationBarObject(
                  item: 1,
                  route: '/FilterView',
                  title: "Explore",
                  iconItem: Icons.explore_outlined),
            ),
            Expanded(
              flex: 1,
              child: NavigationBarObject(
                  item: 2,
                  route: '/FavoritesView',
                  title: "Favorites",
                  iconItem: Icons.favorite_border_outlined),
            ),
            Expanded(
              flex: 1,
              child: NavigationBarObject(
                  item: 3,
                  route: '/DrinkView',
                  title: "Surprise",
                  iconItem: CupertinoIcons.gift),
            ),
          ]),
    );
  }
}
