import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You dont have favorite meals. Add some"),
      );
    }
    else{
    return ListView.builder(itemBuilder: (BuildContext context, int index)=> MealItem(favoriteMeals[index]),
    itemCount: favoriteMeals.length,);
    }
  }
}
