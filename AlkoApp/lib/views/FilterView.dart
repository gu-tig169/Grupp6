import 'package:AlkoApp/model/FilterModel.dart';
import 'package:AlkoApp/widgets/NavigationBar.dart';
import 'package:AlkoApp/objects/IngredientObject.dart';
import 'package:AlkoApp/widgets/CreateDrinkContainer.dart';
import 'package:AlkoApp/widgets/Spinner.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Consumer<FilterModel>(
      builder: (context, state, child) => Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Row(
              children: [
                _searchBar(context, state, editingController),
                _filterButton(context, state, editingController),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _showFilterIngredients(state),
                _clearButton(context, state)
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            _myCustomListView(
                _filter(state.alkoList, state, editingController, context),
                context),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }

  Widget _showFilterIngredients(state) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Chosen ingredients: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Text(
                "${state.listToFilterOn.join(", ").toString()}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _clearButton(context, state) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.18,
      child: Padding(
        padding: EdgeInsets.fromLTRB(3, 0, 7, 0),
        child: FlatButton(
          color: Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Icon(Icons.clear),
          onPressed: () {
            state.listToFilterOn.clear();
            state.setListByIngredient(state.listToFilterOn, context);
          },
        ),
      ),
    );
  }

  Widget _filterButton(BuildContext context, state, editingController) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.15,
      width: MediaQuery.of(context).size.width * 0.20,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 7, 0),
        child: FlatButton(
          color: Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Icon(Icons.filter_alt),
          onPressed: () {
            state.listToFilterOn.clear();
            _filterDialog(context, state);
          },
        ),
      ),
    );
  }

  _filterDialog(BuildContext context, state) async {
    List<IngredientObject> listOfIngredients = await state.getIngredientsList();
    listOfIngredients
        .sort((a, b) => a.strIngredient1.compareTo(b.strIngredient1));
    //Sorterar i bokstavsordning

    Widget filterButton = RaisedButton(
      color: Colors.blueGrey[400],
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Text("Apply filter", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.pop(context);
        state.setListByIngredient(state.listToFilterOn, context);
      },
    );

    Widget cancelButton = RaisedButton(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: Text("Clear all", style: TextStyle(fontSize: 16)),
      onPressed: () {
        Navigator.pop(context);
        state.listToFilterOn.clear();
        state.setListByIngredient(state.listToFilterOn, context);
      },
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<FilterModel>(
          builder: (context, state, child) => AlertDialog(
            backgroundColor: Colors.blueGrey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            //elevation: 20,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    "Filter ingredients",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(width: 8),
                ButtonTheme(
                  minWidth: 5,
                  child: FlatButton(
                    color: Colors.transparent,
                    child: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            content: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: Container(
                      height: MediaQuery.of(context).size.width * 1.2,
                      width: MediaQuery.of(context).size.width * .7,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children:
                            List.generate(listOfIngredients.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                state.setFilterColor(listOfIngredients[index]);

                                //lägger till eller tar bort ur listan beroende på om den redan finns
                                if (state.listToFilterOn.contains(
                                    listOfIngredients[index].strIngredient1)) {
                                  state.listToFilterOn.remove(
                                      listOfIngredients[index].strIngredient1);
                                } else {
                                  state.listToFilterOn.add(
                                      listOfIngredients[index].strIngredient1);
                                }
                              },
                              child: Card(
                                color: state
                                    .getFilterColor(listOfIngredients[index]),
                                child: Stack(
                                  children: [
                                    FadeInImage.assetNetwork(
                                      placeholder:
                                          "assets/images/spinningwheel.gif",
                                      image: listOfIngredients[index].pic,
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          listOfIngredients[index]
                                              .strIngredient1,
                                          style: TextStyle(
                                              backgroundColor:
                                                  Colors.grey[300]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Filters: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        "${state.listToFilterOn.join(", ")}",
                      ),
                    ),
                  ],
                ),
                //_filterMenuSearchBar(editingController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton,
                    SizedBox(width: 10),
                    filterButton,
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar(BuildContext context, state, editingController) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 13, 0, 5),
        child: TextField(
          autofocus: false,
          controller: editingController,
          decoration: InputDecoration(
            labelText: "Search",
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              onPressed: () => editingController.clear(),
              icon: Icon(Icons.clear),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
          ),
        ),
      ),
    );
  }

  _filter(list, state, editingController, context) {
    if (editingController.text != null && editingController.text != "") {
      List filteredList = list
          .where((s) => s.strDrink
              .toString()
              .toLowerCase()
              .contains(editingController.text.toLowerCase()))
          .toList();
      state.setFilteredList(filteredList);

      return state.filteredList;
    } else {
      return list;
    }
  }

  Widget _myCustomListView(list, context) {
    return Expanded(
      child: Consumer<FilterModel>(
        builder: (context, state, child) {
          if (state.isLoading == false && list.length == 0) {
            return Text("No Results:(");
          } else if (state.isLoading == true) {
            return Spinner();
          } else {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              children: List.generate(list.length, (index) {
                return Container(
                  child: CreateDrinkContainer(list[index]),
                );
              }),
            );
          }
        },
      ),
    );
  }
}
