import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:AlkoApp/objects/AlkoObject.dart';

class FavoriteDB {
  static getFavoriteListData() async {
    List<AlkoObject> list;

    String queryURL = 'https://secret-springs-79454.herokuapp.com/';

    http.Response response = await http.get(queryURL);

    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => AlkoObject.fromJson(data))
          .toList();

      return list;
    } else {
      print("ERROR: getFavoriteListData() ERROR: ${response.statusCode}");
    }
  }

  static removeFromFavoriteListData(int idDrink) async {
    String queryURL =
        'https://secret-springs-79454.herokuapp.com/removeObject?idDrink=$idDrink';

    http.Response response = await http.put(queryURL);

    if (response.statusCode == 200) {
    } else {
      print("ERROR: getFavoriteListData() ERROR: ${response.statusCode}");
    }
  }

  static addToFavoriteListData(drink) async {
    String queryURL =
        "https://secret-springs-79454.herokuapp.com/addObject?strDrink=${drink.strDrink}&strDrinkThumb=${drink.strDrinkThumb}&idDrink=${drink.idDrink}&strIngredient1=${drink.strIngredient1}&strIngredient2=${drink.strIngredient2}&strIngredient3=${drink.strIngredient3}&strIngredient4=${drink.strIngredient4}&strIngredient5=${drink.strIngredient5}&strIngredient6=${drink.strIngredient6}&strIngredient7=${drink.strIngredient7}&strIngredient8=${drink.strIngredient8}&strIngredient9=${drink.strIngredient9}&strIngredient10=${drink.strIngredient10}&strIngredient11=${drink.strIngredient11}&strIngredient12=${drink.strIngredient12}&strIngredient13=${drink.strIngredient13}&strIngredient14=${drink.strIngredient14}&strIngredient15=${drink.strIngredient15}&strMeasure1=${drink.strMeasure1}&strMeasure2=${drink.strMeasure2}&strMeasure3=${drink.strMeasure3}&strMeasure4=${drink.strMeasure4}&strMeasure5=${drink.strMeasure5}&strMeasure6=${drink.strMeasure6}&strMeasure7=${drink.strMeasure7}&strMeasure8=${drink.strMeasure8}&strMeasure9=${drink.strMeasure9}&strMeasure10=${drink.strMeasure10}&strMeasure11=${drink.strMeasure11}&strMeasure12=${drink.strMeasure12}&strMeasure13=${drink.strMeasure13}&strMeasure14=${drink.strMeasure14}&strMeasure15=${drink.strMeasure15}&";

    http.Response response = await http.put(queryURL);

    if (response.statusCode == 200) {
    } else {
      print("ERROR: getFavoriteListData() ERROR: ${response.statusCode}");
    }
  }
}
