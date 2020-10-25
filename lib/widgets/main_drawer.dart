import 'package:flutter/material.dart';
import 'package:meals_app/screens/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                CircleAvatar(
                  minRadius: 35,
                  child: Icon(Icons.person, size: 45),
                ),
                SizedBox(height: 10),
                Text(
                  'Ekansh Saxena',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            context: context,
            title: 'Meals',
            iconName: Icons.restaurant,
            tapHandler: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTile(
            context: context,
            title: 'Filter',
            iconName: Icons.settings,
            tapHandler: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          )
        ],
      ),
    );
  }

  ListTile buildListTile(
      {BuildContext context,
      String title,
      IconData iconName,
      Function tapHandler}) {
    return ListTile(
      leading: Icon(iconName),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      onTap: tapHandler,
    );
  }
}
