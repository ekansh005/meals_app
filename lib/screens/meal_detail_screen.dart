import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const String routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen({this.toggleFavorite, this.isFavorite});

  @override
  Widget build(BuildContext context) {
    Map<String, String> routeArgs = ModalRoute.of(context).settings.arguments;
    final String id = routeArgs['id'];
    Meal meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
              SectionTitle('Ingredients'),
              buildContainerForList(
                height: 170,
                child: ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      meal.ingredients[index],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 17),
                    ),
                  ),
                ),
              ),
              SectionTitle('Steps'),
              buildContainerForList(
                height: 300,
                child: ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // child: Icon(Icons.delete),
        child: Icon(isFavorite(meal.id) ? Icons.star : Icons.star_border),
        onPressed: () {
          // Navigator.of(context).pop(meal.id);
          toggleFavorite(meal.id);
        },
      ),
    );
  }

  Container buildContainerForList({Widget child, double height}) {
    return Container(
      height: height,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.pink[30],
      ),
      child: child,
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String titleText;
  const SectionTitle(this.titleText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
