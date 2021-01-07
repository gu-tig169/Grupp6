import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:AlkoApp/DB/CocktailDB.dart';
import 'package:AlkoApp/DB/FavoriteDB.dart';
import 'package:AlkoApp/model/AlkoObject.dart';
import 'package:AlkoApp/model/IngredientObject.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Model extends ChangeNotifier {
  List<AlkoObject> _alkoList = new List();
  List<AlkoObject> _favoriteList = new List();
  List<AlkoObject> _popularList = new List();
  List<AlkoObject> _randomList = new List();
  List listToFilterOn = new List();
  bool _isLoading = false;
  List<AlkoObject> _latestList = new List();
  List _filteredList = List();

  List get filteredList => _filteredList;
  List get alkoList => _alkoList;
  List get favoriteList => _favoriteList;
  List get popularList => _popularList;
  List get randomList => _randomList;
  bool get isLoading => _isLoading;
  List get latestList => _latestList;

  Color _filterColor;

  Model() {
    syncLists();
    getPopularList();
    latestDrinks();
    getFavoriteListData();
  }

  void setFilteredList(List input) {
    _filteredList = List.from(input);
  }

  getFavoriteListData() async {
    _favoriteList = await FavoriteDB.getFavoriteListData();
    notifyListeners();
  }

  void syncLists() async {
    _isLoading = true;
    notifyListeners();
    _alkoList = await CocktailDB.getData();
    _isLoading = false;
    notifyListeners();
  }

  getCocktailsByString(String input, context) async {
    List list = List();
    _isLoading = true;
    list = await CocktailDB.getCocktailsByString(input, context);
    _isLoading = false;
    _alkoList = List.from(list);
    notifyListeners();
  }

  void setFilterColor(object) {
    if (object.getCheck == false) {
      object.setCheck(true);
      notifyListeners();
    } else {
      object.setCheck(false);
      notifyListeners();
    }
  }

  Color getFilterColor(object) {
    if (object.getCheck == false) {
      _filterColor = Colors.white;
      return _filterColor;
    } else {
      _filterColor = Colors.grey[400];
      return _filterColor;
    }
  }

  void setListByIngredient(List listToFilterOn, context) async {
    _isLoading = true;
    notifyListeners();
    if (listToFilterOn.length > 0) {
      _alkoList = await CocktailDB.getDataByIngredient(listToFilterOn, context);
      _isLoading = false;
      notifyListeners();
    } else {
      _alkoList = await CocktailDB.getData();
      _isLoading = false;
      notifyListeners();
    }
  }

  getIngredientsList() async {
    _isLoading = true;
    notifyListeners();
    List<IngredientObject> listOfIngredients = new List();
    listOfIngredients = await CocktailDB.getIngredientsList();
    _isLoading = false;
    notifyListeners();
    return listOfIngredients;
  }

  getSingleObjectByID(id) async {
    _isLoading = true;
    List<AlkoObject> list = await CocktailDB.getSingleObjectByID(id);
    AlkoObject obj = list[0];
    _isLoading = false;
    return obj;
  }

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

  void editFavorite(AlkoObject drink) {
    if (isDrinkInFavorite(drink) == true) {
      drink.isFavorite = false;
      favoriteList.remove(drink);
      var myInt = int.parse(drink.idDrink);
      FavoriteDB.removeFromFavoriteListData(myInt).toString();
      myFlutterToast('Removed from favorites');
    } else {
      print(drink.strIngredient1);
      drink.isFavorite = true;
      favoriteList.add(drink);
      FavoriteDB.addToFavoriteListData(drink);
      myFlutterToast('Added to favorites');
    }
    notifyListeners();
  }

  void removeFavorite(AlkoObject drink) {
    drink.isFavorite = false;
    favoriteList.remove(drink);
    int myInt;
    if (drink.idDrink is String) {
      myInt = int.parse(drink.idDrink);
    } else {
      myInt = drink.idDrink;
    }

    FavoriteDB.removeFromFavoriteListData(myInt);
    notifyListeners();
  }

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

  void setFavoriteIcon(AlkoObject drink) {
    if (drink.isFavorite == false) {
      drink.isFavorite = true;
    } else {
      drink.isFavorite = false;
    }
    notifyListeners();
  }

  //Används för att hämta de mest populära, som visas på startView
  void getPopularList() async {
    _isLoading = true;
    notifyListeners();
    _popularList = await CocktailDB.getPopularDrinks();
    _isLoading = false;
    notifyListeners();
  }

  //Används för att hämta en random drink, används på startview
  void randomDrink() async {
    _isLoading = true;
    notifyListeners();
    _randomList = await CocktailDB.getRandomDrink();
    _isLoading = false;
    notifyListeners();
  }

  void latestDrinks() async {
    _isLoading = true;
    notifyListeners();
    _latestList = await CocktailDB.getLatestDrinks();
    _isLoading = false;
    notifyListeners();
  }

  getIngredientImage(String ingredient) async {
    return await CocktailDB.getIngredientImage(ingredient);
  }

  Map getDrinkIngredientList(AlkoObject drink) {
    Map<String, String> parameterList = {
      drink.strIngredient1: drink.strMeasure1,
      drink.strIngredient2: drink.strMeasure2,
      drink.strIngredient3: drink.strMeasure3,
      drink.strIngredient4: drink.strMeasure4,
      drink.strIngredient5: drink.strMeasure5,
      drink.strIngredient6: drink.strMeasure6,
      drink.strIngredient7: drink.strMeasure7,
      drink.strIngredient8: drink.strMeasure8,
      drink.strIngredient9: drink.strMeasure9,
    };

    parameterList.removeWhere((String value, String key) => value == null);
    parameterList.removeWhere((String value, String key) => value == "");

    return parameterList;
  }

  Color _inspirationColor = Colors.blueGrey[400];
  Color _exploreColor = Colors.blueGrey[400];
  Color _favoritesColor = Colors.blueGrey[400];

  void setIconColor(item) {
    _inspirationColor = Colors.blueGrey[400];
    _exploreColor = Colors.blueGrey[400];
    _favoritesColor = Colors.blueGrey[400];
    if (item == 0) {
      _inspirationColor = Colors.blueGrey[900];
    } else if (item == 1) {
      _exploreColor = Colors.blueGrey[900];
    } else {
      _favoritesColor = Colors.blueGrey[900];
    }
    notifyListeners();
  }

  Color getIconColor(item) {
    if (item == 0) {
      return _inspirationColor;
    } else if (item == 1) {
      return _exploreColor;
    } else {
      return _favoritesColor;
    }
  }
}
