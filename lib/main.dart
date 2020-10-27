import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_meal/details.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Meals App"),
        ),
        body: HomePage(),
      ),
    );
  }
}

class Meals {
  final String strMeal;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String strCategory;

  Meals(this.strMeal, this.strArea, this.strInstructions, this.strMealThumb,
      this.strCategory);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Meals>> getMeals() async {
    var data = await http
        .get("https://www.themealdb.com/api/json/v1/1/search.php?f=e");
    var jsonData = json.decode(data.body);
    var mealsData = jsonData['meals'];
    List<Meals> meals = [];
    for (var data in mealsData) {
      Meals mealsItem = Meals(data['strMeal'], data['strArea'],
          data['strInstructions'], data['strMealThumb'], data['strCategory']);
      meals.add(mealsItem);
    }
    return meals;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Meals meals = Meals(
                        snapshot.data[index].strMeal,
                        snapshot.data[index].strArea,
                        snapshot.data[index].strInstructions,
                        snapshot.data[index].strMealThumb,
                        snapshot.data[index].strCategory);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MealsDetail(
                                  mealss: meals,
                                )));
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          snapshot.data[index].strMealThumb == null
                              ? Image.network(
                                  "https://lifeonthebackofanelephant.files.wordpress.com/2013/06/khao-soi.jpg?w=584",
                                  height: 100,
                                  width: 100,
                                )
                              : Image.network(
                                  snapshot.data[index].strMealThumb,
                                  height: 100,
                                  width: 100,
                                ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text("Meal Name :"),
                                  Text(snapshot.data[index].strMeal)
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Category:"),
                                  Text(snapshot.data[index].strCategory)
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Area :"),
                                  Text(snapshot.data[index].strArea)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // if you need this
                      side: BorderSide(
                        color: Colors.pink[100],
                        width: 1,
                      ),
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.length,
              //  child: Text("${snapshot.data[1].title}"),
            );
          }
        },
        future: getMeals(),
      ),
    );
  }
}
