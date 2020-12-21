import 'package:AlkoApp/model/AlkoObject.dart';
import 'package:AlkoApp/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';
import 'package:AlkoApp/model/NavigationBar.dart';

class DrinkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AlkoObject drink = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _imageWidget(context, drink),
              _fakeAppBar(context, drink),
              _titleWidget(drink),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _categoryWidget(drink.strCategory),
                            _alcoholWidget(drink.strAlcoholic),
                            _glassWidget(drink.strGlass),
                          ],
                        ),
                      ),
                      _ingredientsList(
                        measure1: drink.strMeasure1,
                        ingredient1: drink.strIngredient1,
                        measure2: drink.strMeasure2,
                        ingredient2: drink.strIngredient2,
                        measure3: drink.strMeasure3,
                        ingredient3: drink.strIngredient3,
                        measure4: drink.strMeasure4,
                        ingredient4: drink.strIngredient4,
                        measure5: drink.strMeasure5,
                        ingredient5: drink.strIngredient5,
                        measure6: drink.strMeasure6,
                        ingredient6: drink.strIngredient6,
                        measure7: drink.strMeasure7,
                        ingredient7: drink.strIngredient7,
                      ),
                      _customDivider(),
                      _instructionWidget(drink.strInstructions),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

_titleWidget(AlkoObject drink) {
  return Positioned(
    left: 20.0,
    bottom: 20.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          drink.strDrink,
          style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(4.0, 3.0),
                blurRadius: 15.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

_fakeAppBar(BuildContext context, AlkoObject drink) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        Consumer<Model>(
          builder: (context, state, child) => IconButton(
            icon: state.getFavoriteIcon(drink),
            iconSize: 34,
            onPressed: () {
              state.setFavoriteIcon(drink);
              state.editFavorite(drink);
            },
          ),
        )
      ],
    ),
  );
}

Widget _imageWidget(BuildContext context, AlkoObject drink) {
  return Container(
    height: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0.0, 10.0),
          blurRadius: 10.0,
        ),
      ],
    ),
    child: Hero(
      tag: drink.strDrinkThumb,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image(
          image: NetworkImage(drink.strDrinkThumb),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget _ingredientsList({
  String measure1,
  String ingredient1,
  String measure2,
  String ingredient2,
  String measure3,
  String ingredient3,
  String measure4,
  String ingredient4,
  String measure5,
  String ingredient5,
  String measure6,
  String ingredient6,
  String measure7,
  String ingredient7,
}) {
  Map<String, String> parameterList = {
    measure1: ingredient1,
    measure2: ingredient2,
    measure3: ingredient3,
    measure4: ingredient4,
    measure5: ingredient5,
    measure6: ingredient6,
    measure7: ingredient7,
  };

  parameterList.removeWhere((String key, String value) => value == null);

  print(parameterList);

  return _ingredientsWidget(parameterList);
}

Widget _ingredientsWidget(Map<String, String> parameterList) {
  return Column(children: [
    Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        "Ingredients",
        style: TextStyle(
          letterSpacing: 1.0,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    for (var s in parameterList.keys)
      Container(
          alignment: Alignment.topLeft,
          child: ListTile(
            leading: Container(
              child: Image(
                  image: NetworkImage(
                      "https://www.thecocktaildb.com/images/ingredients/${parameterList[s]}-Small.png")),
            ),
            title: Text(
              "${parameterList[s]}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3),
            ),
            subtitle: Text(
              "$s",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ))
  ]);
}

Widget _customDivider() {
  return Divider(
    height: 25,
    thickness: 1,
    indent: 10,
    endIndent: 10,
    color: Colors.grey[600],
  );
}

Widget _glassWidget(String glass) {
  return Expanded(
    child: Column(
      children: [
        Container(
          child: Text(
            "Serve in",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          child: Text(
            glass,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _alcoholWidget(String alcohol) {
  return Expanded(
    child: Column(
      children: [
        Container(
          child: Text(
            "Type",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          child: Text(
            alcohol,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _categoryWidget(String category) {
  return Expanded(
    child: Column(
      children: [
        Container(
          child: Text(
            "Category",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          child: Text(
            category,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _instructionWidget(String instruction) {
  return Column(
    children: [
      Container(
        alignment: Alignment.topLeft,
        child: Text(
          "Instructions",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          instruction,
          style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

Widget _tagWidget(String tag) {
  if (tag == null) {
    return Text("", style: TextStyle(fontSize: 32));
  } else {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      padding: EdgeInsets.all(5),
      // TAGGAR, finns i strTags.
      child: Text(tag,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          )),
    );
  }
}
