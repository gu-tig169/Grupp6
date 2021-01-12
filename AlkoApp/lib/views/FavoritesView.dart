import 'package:AlkoApp/model/FavoriteModel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:AlkoApp/widgets/NavigationBar.dart';
import 'package:AlkoApp/widgets/CreateDrinkContainer.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
      builder: (context, state, child) => Scaffold(
          backgroundColor: Colors.blueGrey[50],
          bottomNavigationBar: CustomNavigationBar(),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'My Favorites',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              (state.favoriteList.length == 0)
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 250.0),
                        child: Text("No saved favorites",
                            style: TextStyle(fontSize: 30)),
                      ),
                    )
                  : Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        children:
                            List.generate(state.favoriteList.length, (index) {
                          return Container(
                            child: Stack(
                              children: [
                                CreateDrinkContainer(state.favoriteList[index]),
                                _deleteButton(state, index)
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
            ],
          )),
    );
  }

  Widget _deleteButton(state, index)  {
    return Positioned(
      right: 15,
      top: 10,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 30.0)
        ]),
        child: IconButton(
          icon: Icon(Icons.highlight_remove, color: Colors.white, size: 40.0),
          onPressed: () {
            state.editFavorite(state.favoriteList[index]);
          },
        ),
      ),
    );
  }
}
