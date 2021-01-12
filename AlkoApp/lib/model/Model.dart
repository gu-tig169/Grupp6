import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AlkoApp/DB/CocktailDB.dart';
import 'package:AlkoApp/objects/AlkoObject.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Model extends ChangeNotifier {
  List<AlkoObject> _randomList = new List();
  List<AlkoObject> _popularList = new List();
  List<AlkoObject> _latestList = new List();

  //Färgerna för navigationBar
  Color _inspirationColor = Colors.blueGrey[900];
  Color _exploreColor = Colors.blueGrey[400];
  Color _favoritesColor = Colors.blueGrey[400];
  Color _supriseColor = Colors.blueGrey[400];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List get latestList => _latestList;
  List get popularList => _popularList;
  List get randomList {
    randomDrink();
    return _randomList;
  }

  Model() {
    randomDrink();
    getPopularList();
    latestDrinks();
  }

  //Används för att hämta de mest populära, som visas på startView
  void getPopularList() async {
    _isLoading = true;
    notifyListeners();
    _popularList = await CocktailDB.getPopularDrinks();
    _isLoading = false;
    notifyListeners();
  }

  //Senaste tillagda drinks som visas på startview
  void latestDrinks() async {
    _isLoading = true;
    notifyListeners();
    _latestList = await CocktailDB.getLatestDrinks();
    _isLoading = false;
    notifyListeners();
  }

  //Hämtar ett objekt mha ID, används i DrinkView
  getSingleObjectByID(id) async {
    _isLoading = true;
    List<AlkoObject> list = await CocktailDB.getSingleObjectByID(id);
    AlkoObject obj = list[0];
    _isLoading = false;
    return obj;
  }

  //Mappar ingredienser och measure, används i drinkview & createdrinkcontainer
  Map getDrinkIngredientList(AlkoObject drink) {
    Map<String, String> ingredientMap = {
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

    ingredientMap.removeWhere((String value, String key) => value == null);
    ingredientMap.removeWhere((String value, String key) => value == "");

    return ingredientMap;
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

  void randomDrink() async {
    _isLoading = true;
    notifyListeners();
    _randomList = await CocktailDB.getRandomDrink();
    _isLoading = false;
    notifyListeners();
  }

  void setIconColor(item) {
    _inspirationColor = Colors.blueGrey[400];
    _exploreColor = Colors.blueGrey[400];
    _favoritesColor = Colors.blueGrey[400];
    _supriseColor = Colors.blueGrey[400];

    if (item == 0) {
      _inspirationColor = Colors.blueGrey[900];
    } else if (item == 1) {
      _exploreColor = Colors.blueGrey[900];
    } else if (item == 2) {
      _favoritesColor = Colors.blueGrey[900];
    } else if (item == 3) {
      _supriseColor = Colors.blueGrey[900];
    }
    notifyListeners();
  }

  Color getIconColor(item) {
    if (item == 0) {
      return _inspirationColor;
    } else if (item == 1) {
      return _exploreColor;
    } else if (item == 2) {
      return _favoritesColor;
    } else {
      return _supriseColor;
    }
  }
}
