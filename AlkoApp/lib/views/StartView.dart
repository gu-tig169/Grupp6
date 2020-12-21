import 'package:AlkoApp/model/Model.dart';
import 'package:AlkoApp/widgets/LatestDrinksCarousel.dart';
import 'package:AlkoApp/widgets/PopularDrinkCarousel.dart';
import 'package:flutter/material.dart';
import 'package:AlkoApp/model/NavigationBar.dart';
import 'package:provider/provider.dart';

class StartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, state, child) => Scaffold(
        body: ListView(
          children: [
            PopularDrinkCarousel(),
            Container(
              height: 50,
              width: 500,
              child: Padding(
                padding: EdgeInsets.fromLTRB(80, 0, 80, 10),
                child: _supriseButton(context, state),
              ),
            ),
            LatestDrinksCarousel(),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }

  Widget _supriseButton(BuildContext context, state) {
    return RaisedButton(
        color: Colors.pinkAccent,
        onPressed: () {
          state.randomDrink();
          Navigator.pushNamed(context, '/DrinkView',
              arguments: state.randomList[0].idDrink);
        },
        child: Text("Suprise Me!"));
  }
}
