import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter {
  gluttenFree,
  lactoseFree,
  vegeterian,
  vegan,
}

const initState = {
  Filter.gluttenFree: false,
  Filter.lactoseFree: false,
  Filter.vegeterian: false,
  Filter.vegan: false
};
const filterTitles = {
  Filter.gluttenFree: 'Glutten-free',
  Filter.lactoseFree: 'Lactose-free',
  Filter.vegeterian: 'Vegetarian',
  Filter.vegan: 'Vegan',
};

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(initState);

  Filter _findFilterByString(String title) {
    Filter? finalKey;

    filterTitles.forEach(
      (key, value) {
        if (value == title) {
          finalKey = key;
        }
      },
    );

    return finalKey ?? Filter.gluttenFree;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilterByTitle(String filterTitle, bool isActive) {
    final filter = _findFilterByString(filterTitle);
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  
  return meals.where(
    (meal) {
      if (activeFilters[Filter.gluttenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegeterian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    },
  ).toList();
});
