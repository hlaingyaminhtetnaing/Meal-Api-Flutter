import 'package:flutter/material.dart';

import 'main.dart';

class MealsDetail extends StatelessWidget {
  final Meals mealss;

  const MealsDetail({Key key, this.mealss}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: Column(
          children: [
            mealss.strMealThumb == null
                ? Image.network(
                    "https://lifeonthebackofanelephant.files.wordpress.com/2013/06/khao-soi.jpg?w=584",
                    height: 100,
                  )
                : Image.network(
                    mealss.strMealThumb,
                    height: 100,
                  ),
            Text(mealss.strMeal),
            Text(mealss.strCategory),
            Text(mealss.strArea),
            Text(mealss.strInstructions,
                overflow: TextOverflow.clip, softWrap: false),
          ],
        ),
      ),
    );
  }
}
