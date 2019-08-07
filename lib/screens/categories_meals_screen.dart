import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const String routeName = 'CategoriesMealsScreen';
  final List<Meal> availableMeal;
  CategoriesMealsScreen(this.availableMeal);
  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool loadedData = false;
  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    if (!loadedData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final id = routeArgs['id'];
      displayedMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(id);
      }).toList();
    }
    loadedData = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(displayedMeals[index]);
          },
          itemCount: displayedMeals.length,
        ));
  }
}
