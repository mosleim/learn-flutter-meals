import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/FiltersScreen.dart';
import './screens/meal_detil.dart';
import './screens/tabs_screen.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }
  bool _isMealFavorites(String mealId) {
    return _favoriteMeals.any((meal)=>meal.id==mealId);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metal Andon',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            body1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            body2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            title: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoriesMealsScreen.routeName: (ctx) =>
            CategoriesMealsScreen(_availableMeals),
        MealDetil.routeName: (ctx) => MealDetil(_isMealFavorites,_toggleFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
