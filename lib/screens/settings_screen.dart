import 'package:flutter/material.dart';
import 'package:meals_app/models/filters.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  final Filters currentFilters;
  final Function saveFilters;

  const SettingsScreen({this.saveFilters, this.currentFilters});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glutenFree;
  bool _vegan;
  bool _vegetarian;
  bool _lactoseFree;

  @override
  void initState() {
    _glutenFree = widget.currentFilters.glutenFree;
    _vegan = widget.currentFilters.vegan;
    _vegetarian = widget.currentFilters.vegetarian;
    _lactoseFree = widget.currentFilters.lactoseFree;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveFilters(new Filters(
                glutenFree: _glutenFree,
                vegan: _vegan,
                vegetarian: _vegetarian,
                lactoseFree: _lactoseFree,
              ));
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Adjust your filters here!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  title: 'Gluten Free',
                  subtitle: 'show only gluten free meals',
                  filterVariable: _glutenFree,
                  changeHandler: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegan',
                  subtitle: 'show only vegan meals',
                  filterVariable: _vegan,
                  changeHandler: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Vegetarian',
                  subtitle: 'show only vegetarian meals',
                  filterVariable: _vegetarian,
                  changeHandler: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  title: 'Lactose Free',
                  subtitle: 'show only lactose free meals',
                  filterVariable: _lactoseFree,
                  changeHandler: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile({
    String title,
    String subtitle,
    bool filterVariable,
    Function changeHandler,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: filterVariable,
      onChanged: changeHandler,
    );
  }
}
