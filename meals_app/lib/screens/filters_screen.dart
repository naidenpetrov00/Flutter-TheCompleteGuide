import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/widgets/switch_list_item.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

class FiltersScreen extends StatelessWidget {
  final Map<Filter, bool> currentFilters;

  FiltersScreen({super.key, required this.currentFilters});

  final _filterTitles = {
    Filter.gluttenFree: 'Glutten-free',
    Filter.lactoseFree: 'Lactose-free',
    Filter.vegeterian: 'Vegetarian',
    Filter.vegan: 'Vegan',
  };
  // final _filterStates = currentFilters;

  void _setStates(String title, bool state) {
    Filter? finalKey;

    _filterTitles.forEach(
      (key, value) {
        if (value == title) {
          finalKey = key;
        }
      },
    );
    currentFilters[finalKey!] = state;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        // drawer: MainDrawer(onSelectScreen: (identifier) {
        //   if (identifier == 'meals') {
        //     Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(
        //         builder: (tabsContext) => const TabsScreen(),
        //       ),
        //     );
        //   }
        // }),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            Navigator.of(context).pop(currentFilters);
          },
          child: Column(
            children: [
              SwitchListItem(
                title: _filterTitles[Filter.gluttenFree]!,
                onSwicth: _setStates,
                initState: currentFilters[Filter.gluttenFree]!,
              ),
              SwitchListItem(
                title: _filterTitles[Filter.lactoseFree]!,
                onSwicth: _setStates,
                initState: currentFilters[Filter.lactoseFree]!,
              ),
              SwitchListItem(
                title: _filterTitles[Filter.vegeterian]!,
                onSwicth: _setStates,
                initState: currentFilters[Filter.vegeterian]!,
              ),
              SwitchListItem(
                title: _filterTitles[Filter.vegan]!,
                onSwicth: _setStates,
                initState: currentFilters[Filter.vegan]!,
              ),
            ],
          ),
        ),
      );
}
