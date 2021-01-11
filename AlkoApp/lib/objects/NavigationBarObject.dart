import 'package:AlkoApp/model/FavoriteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:AlkoApp/model/Model.dart';

class NavigationBarObject extends StatelessWidget {
  final double _iconSize = 0.05;
  final double _fontSize = 0.018;

  final int item;
  final String route;
  final String title;
  final IconData iconItem;

  NavigationBarObject({this.item, this.route, this.title, this.iconItem});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Model>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        children: [
          IconButton(
              icon: Icon(iconItem,
                  size: MediaQuery.of(context).size.height * _iconSize,
                  color: provider.getIconColor(item)),
              onPressed: () {
                if (item == 3) {
                  Navigator.pushNamed(context, route,
                      arguments: provider.randomList[0].idDrink);
                } else {
                  Navigator.pushReplacementNamed(context, route);
                  Provider.of<FavoriteModel>(context, listen: false)
                      .getFavoriteListData();
                }
                provider.setIconColor(item);
              }),
          Text(title,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * _fontSize,
                  color: provider.getIconColor(item)))
        ],
      ),
    );
  }
}
