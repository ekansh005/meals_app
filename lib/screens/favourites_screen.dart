import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavouritesScreen({this.favoriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child:
            Text('You have no favorites. Please add some from meal details.'),
      );
    } else {
      return Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: favoriteMeals[index],
              // removeItem: _removeMeal,
            );
          },
          itemCount: favoriteMeals.length,
        ),
      );
    }
  }
}
