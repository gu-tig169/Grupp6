import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:AlkoApp/model/Model.dart';

class AgeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bar2.jfif'),
                fit: BoxFit.cover),
          ),
        ),
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: Color.fromRGBO(186, 186, 186, 0.75)),
            child: Column(
              children: [
                _logo(context),
                _ageControl(context),
              ],
            ),
          ),
        ),
      ]),
    );
  }

//logo
  Widget _logo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Image(
        height: MediaQuery.of(context).size.height * 0.3,
        image: AssetImage("assets/images/Logo.png"),
      ),
    );
  }

  //Widget för de två knapparna för ålderkontroll
  _ageControl(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
          child: Text(
            "This app contains alcoholic content and you need to be over 20 years to access it.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: RaisedButton(
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/StartView');
            },
            textColor: Colors.black,
            child: Text('I am at least 20 years old',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            color: Colors.white,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: RaisedButton(
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
            onPressed: () {
              Provider.of<Model>(context, listen: false).myFlutterToast(
                  "You need to be at least 20 years old to use this app, try again ;)");
            },
            textColor: Colors.black,
            child: Text('I am younger than 20 years old',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
