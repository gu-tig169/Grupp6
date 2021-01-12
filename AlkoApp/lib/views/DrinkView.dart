import 'package:AlkoApp/model/FavoriteModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart';

import 'package:AlkoApp/objects/AlkoObject.dart';
import 'package:AlkoApp/model/Model.dart';
import 'package:AlkoApp/widgets/NavigationBar.dart';
import 'package:AlkoApp/widgets/Spinner.dart';

class DrinkView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Ser till att drinkobjektet hämtas
    var id = ModalRoute.of(context).settings.arguments;

    //Objektet heter nu drink.data
    return FutureBuilder<AlkoObject>(
      future: _getDrink(context, id),
      builder: (BuildContext context, AsyncSnapshot<AlkoObject> drink) {
        if (drink.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            body: Spinner(),
          );
        } else {
          if (drink.hasError)
            return Center(child: Text('Error: ${drink.error}'));
          else
            return Scaffold(
              backgroundColor: Color(0xFFF4F4F4),
              body: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _imageWidget(drink, context),
                      _customAppbar(drink, context),
                      _titleWidget(drink, context),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _categoryWidget(drink.data.strCategory),
                                    _alcoholWidget(drink.data.strAlcoholic),
                                    _glassWidget(drink.data.strGlass),
                                  ],
                                ),
                              ),
                              _customDivider(),
                              _ingredientsWidget(drink.data, context),
                              _customDivider(),
                              _instructionWidget(drink.data.strInstructions),
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
      },
    );
  }
}

//Namnet på drinken
_titleWidget(AsyncSnapshot<AlkoObject> drink, BuildContext context) {
  // TITEL
  return Positioned(
    left: 20.0,
    bottom: 20.0,
    right: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          drink.data.strDrink,
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

//Tillbaka och hjärtikonen på en drinkView
Widget _customAppbar(AsyncSnapshot<AlkoObject> drink, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 30.0,
              ),
            ],
          ),
          child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {
                Provider.of<Model>(context, listen: false).setIconColor(4);
                Navigator.pop(context);
              }),
        ),
        Consumer<FavoriteModel>(
          builder: (context, state, child) => Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 30.0,
                ),
              ],
            ),
            child: IconButton(
              icon: state.getFavoriteIcon(drink: drink.data),
              iconSize: 34,
              onPressed: () {
                state.setFavoriteIcon(drink.data);
                state.editFavorite(drink.data);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

//Bilden på drink
Widget _imageWidget(AsyncSnapshot<AlkoObject> drink, context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0.0, 2.0),
          blurRadius: 6.0,
        ),
      ],
    ),
    child: Hero(
      tag: drink.data.strDrinkThumb,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
        child: Image(
          image: NetworkImage(drink.data.strDrinkThumb),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

//Kallar på metod som hämtar ett objekt m.h.a. ID
Future<AlkoObject> _getDrink(context, id) async {
  AlkoObject drink =
      await Provider.of<Model>(context, listen: false).getSingleObjectByID(id);
  return drink;
}

//Widget för att ta emot alla ingredients, bilder  och measures för en drink och mappa ihop dem
Widget _ingredientsWidget(
  AlkoObject drink,
  context,
) {
  Map<String, String> ingredientMap =
      Provider.of<Model>(context, listen: false).getDrinkIngredientList(drink);

  return Column(children: [
    Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Ingredients",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    for (var k in ingredientMap.keys)

      Container(
        alignment: Alignment.topLeft,
        child: ListTile(
          leading: Image(
              image: NetworkImage(
                  "https://www.thecocktaildb.com/images/ingredients/$k-Small.png")),
          visualDensity: VisualDensity(horizontal: 0, vertical: 0),
          title: Text(
            "$k",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.3),
          ),
          subtitle: Text(
            ingredientMap[k] == null ? "" : "${ingredientMap[k]}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      )
  ]);
}

//Horisontell linje som används i ListView
Widget _customDivider() {
  return Divider(
    height: 25,
    thickness: 1,
    indent: 10,
    endIndent: 10,
    color: Colors.grey[600],
  );
}

//Visar vilket glass som rekommenderas
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

//Om den är alkoholhaltig eller inte
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

//Vilken kategori drinken tillhör
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

//Instruktionerna som visas om en drink
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
