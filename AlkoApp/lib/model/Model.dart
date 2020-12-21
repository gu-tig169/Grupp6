import 'package:AlkoApp/model/AlkoObject.dart';
import 'package:AlkoApp/model/IngredientObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:AlkoApp/DB/DB.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Model extends ChangeNotifier {
  List<AlkoObject> _alkoList = new List();
  List<AlkoObject> _favoriteList = new List();
  List listToFilterOn = new List();

  List get alkoList => _alkoList;
  List get favoriteList => _favoriteList;

  Color _filterColor;

  Model() {
    syncLists();
  }

  void syncLists() async {
    print("Loading...");
    _alkoList = await DB.getData();
    notifyListeners();
    print("DONE!");
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
      _filterColor = Colors.grey[300];
      return _filterColor;
    } else {
      _filterColor = Colors.grey[600];
      return _filterColor;
    }
  }

  void setListByIngredient(List listToFilterOn, context) async {
    if (listToFilterOn.length > 0) {
      _alkoList = await DB.getDataByIngredient(listToFilterOn, context);
      notifyListeners();
    } else {
      _alkoList = await DB.getData();
      notifyListeners();
    }
  }

  getIngredientsList() async {
    List<IngredientObject> listOfIngredients = new List();
    listOfIngredients = await DB.getIngredientsList();
    return listOfIngredients;
  }

  myFlutterToast(input) {
    return Fluttertoast.showToast(
      msg: input,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey.shade300,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  //Kan bugga med den andra index högre upp/Olle
  //Variabel, getter & setter för NavigationBar
  int _currentIndex = 0;
  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void addFavorite(AlkoObject drink) {
    favoriteList.add(drink);
    notifyListeners();
  }
}
