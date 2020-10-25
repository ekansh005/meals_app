import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/filters.dart';

import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filters _filters = new Filters();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _saveFilters(Filters newFilters) {
    setState(() {
      _filters = newFilters;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters.glutenFree && !meal.isGlutenFree) {
          return false;
        }
        if (_filters.vegan && !meal.isVegan) {
          return false;
        }
        if (_filters.vegetarian && !meal.isVegetarian) {
          return false;
        }
        if (_filters.lactoseFree && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    var existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      //meal was favourite so now remove it
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deli Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isFavorite,
            ),
        SettingsScreen.routeName: (ctx) =>
            SettingsScreen(currentFilters: _filters, saveFilters: _saveFilters),
      },
      onGenerateRoute: (settings) {
        //this method is called when route name is not available in
        //routes array above, we can generate a route at runtime
        return (settings.name == '/something'
            ? MaterialPageRoute(builder: (ctx) => TabsScreen())
            : null);
      },
      onUnknownRoute: (settings) {
        //this method is called when route name is not available in
        //routes array above and there is no route generated at runtime as well
        //so as a 404 we navigate to a default screen
        return MaterialPageRoute(builder: (ctx) => TabsScreen());
      },
    );
  }
}
