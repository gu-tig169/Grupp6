import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:AlkoApp/DB/FavoriteDB.dart';
import 'package:AlkoApp/objects/AlkoObject.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteModel extends ChangeNotifier {
  List<AlkoObject> _favoriteList = new List();

  List get favoriteList => _favoriteList;

  FavoriteModel() {
    getFavoriteListData();
  }

  //ALLT MED FAVORITE
  //Hämtar mha favoriteDB favoritlistan
  getFavoriteListData() async {
    _favoriteList = await FavoriteDB.getFavoriteListData();
    notifyListeners();
  }

  //Metod för att kolla om ett objekt är favoritet
  bool isDrinkInFavorite(drink) {
    for (int i = 0; i < favoriteList.length; i++) {
      if (favoriteList[i]
          .idDrink
          .toString()
          .contains(drink.idDrink.toString())) {
        return true;
      }
    }
    return false;
  }

  //Metod för att skifta status på ett objkekt som är favorit samt ta bort från favoritlistan
  void editFavorite(AlkoObject drink) async {
    if (isDrinkInFavorite(drink) == true) {
      drink.isFavorite = false;
      favoriteList.remove(drink);
      int myInt;
      if (drink.idDrink is String) {
        myInt = int.parse(drink.idDrink);
      } else {
        myInt = drink.idDrink;
      }
      await FavoriteDB.removeFromFavoriteListData(myInt);
      await getFavoriteListData();
      myFlutterToast('Removed from favorites');
    } else {
      drink.isFavorite = true;
      favoriteList.add(drink);
      await FavoriteDB.addToFavoriteListData(drink);
      await getFavoriteListData();
      myFlutterToast('Added to favorites');
    }
    notifyListeners();
  }

  //Favorite
  Icon getFavoriteIcon({AlkoObject drink}) {
    if (isDrinkInFavorite(drink) == true) {
      var filledIcon = Icon(Icons.favorite, color: Colors.white);
      return filledIcon;
    } else {
      var outLinedIcon =
          Icon(Icons.favorite_border_outlined, color: Colors.white);
      return outLinedIcon;
    }
  }

  //favorite
  void setFavoriteIcon(AlkoObject drink) {
    if (drink.isFavorite == false) {
      drink.isFavorite = true;
    } else {
      drink.isFavorite = false;
    }
    notifyListeners();
  }

  //Modellen för Toasts som används
  myFlutterToast(input) {
    return Fluttertoast.showToast(
      msg: input,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      fontSize: 20.0,
    );
  }
}
