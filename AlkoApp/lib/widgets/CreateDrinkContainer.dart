import 'package:AlkoApp/objects/AlkoObject.dart';
import 'package:AlkoApp/model/Model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateDrinkContainer extends StatelessWidget {
  final AlkoObject drink;
  CreateDrinkContainer(this.drink);
  @override
  Widget build(BuildContext context) {
    Map<String, String> parameterList =
        Provider.of<Model>(context, listen: false)
            .getDrinkIngredientList(drink);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/DrinkView', arguments: drink.idDrink);
      },
      child: Stack(
        children: [
          backgroundContainer(context),
          Container(
            width: 210.0,
            child: Column(
              //alignment: Alignment.topCenter,
              children: <Widget>[
                picContainer(),
                ingredientList(parameterList, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget backgroundContainer(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 80, 6, 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget picContainer() {
    return Stack(
      children: <Widget>[
        Hero(
          tag: drink.strDrinkThumb,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              height: 180.0,
              width: 180.0,
              fit: BoxFit.cover,
              placeholder: "assets/images/spinningwheel.gif",
              image: (drink.strDrinkThumb == null)
                  ? "assets/images/noimage.png"
                  : drink.strDrinkThumb,
            ),
          ),
        ),
        Positioned(
          left: 10.0,
          bottom: 10.0,
          right: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 170,
                child: Text(
                  "${drink.strDrink}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(4.0, 3.0),
                        blurRadius: 13.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ingredientList(Map parameterList, context) {
    parameterList.removeWhere((key, value) =>
        key == "null" || key == null );

    return Padding(
      padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //padding: EdgeInsets.only(top: 30),
            alignment: Alignment.topLeft,
            child: Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.height,
            child: Text(
              "${parameterList.keys.join(', ')}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}

//parameterList[k] == null ? "" : "${parameterList[k]}",
