import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:AlkoApp/DB/CocktailDB.dart';
import 'package:AlkoApp/objects/AlkoObject.dart';
import 'package:AlkoApp/objects/IngredientObject.dart';
import 'package:provider/provider.dart';

import 'Model.dart';

class FilterModel extends ChangeNotifier {
  List<AlkoObject> _alkoList = new List();
  List listToFilterOn = new List();
  List _filteredList = List();

  bool _isLoading = false;

  List get alkoList => _alkoList;
  List get filteredList => _filteredList;
  bool get isLoading => _isLoading;

  Color _filterColor;

  FilterModel() {
    getAlkoList();
  }

//Den filtrerade listan i filterview
  void setFilteredList(List input) {
    _filteredList = List.from(input);
  }

  //Hämtar hela alkoListan från cocktailDB, som visas i filtervy
  void getAlkoList() async {
    _isLoading = true;
    notifyListeners();
    _alkoList = await CocktailDB.getData();
    _isLoading = false;
    notifyListeners();
  }

  //Listan som skapas utifrån sökfältet i filtervy
  getCocktailsByString(String input, context) async {
    List list = List();
    _isLoading = true;
    list = await CocktailDB.getCocktailsByString(input, context);
    _isLoading = false;
    _alkoList = List.from(list);
    notifyListeners();
  }

  //Sätter valda filterobjekt till markerad eller omarkerad i filtervy
  void setFilterColor(object) {
    if (object.getCheck == false) {
      object.setCheck(true);
      notifyListeners();
    } else {
      object.setCheck(false);
      notifyListeners();
    }
  }

  //Hämtar värdet för varje enskilt filterobjekt
  Color getFilterColor(object) {
    if (object.getCheck == false) {
      _filterColor = Colors.white;
      return _filterColor;
    } else {
      _filterColor = Colors.grey[400];
      return _filterColor;
    }
  }

  //Sätter den filtrerade listan om det finns, annars AlkoList i filtervy
  void setListByIngredient(List listToFilterOn, context) async {
    _isLoading = true;
    notifyListeners();
    if (listToFilterOn.length > 0) {
      List tempList = [];
      tempList = await CocktailDB.getDataByIngredient(listToFilterOn, context);

      _alkoList.clear();

      for (int i = 0; i < tempList.length; i++) {
        _alkoList.add(await Provider.of<Model>(context, listen: false)
            .getSingleObjectByID(tempList[i].idDrink));
      }

      _isLoading = false;
      notifyListeners();
    } else {
      _alkoList = await CocktailDB.getData();
      _isLoading = false;
      notifyListeners();
    }
  }

  //Getter för ovan
  getIngredientsList() async {
    _isLoading = true;
    notifyListeners();
    List<IngredientObject> listOfIngredients = new List();
    listOfIngredients = await CocktailDB.getIngredientsList();
    _isLoading = false;
    notifyListeners();
    return listOfIngredients;
  }
}
