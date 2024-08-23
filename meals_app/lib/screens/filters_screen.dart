import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/switch_list_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListItem(
            title: filterTitles[Filter.gluttenFree]!,
            initState: currentFilters[Filter.gluttenFree]!,
          ),
          SwitchListItem(
            title: filterTitles[Filter.lactoseFree]!,
            initState: currentFilters[Filter.lactoseFree]!,
          ),
          SwitchListItem(
            title: filterTitles[Filter.vegeterian]!,
            initState: currentFilters[Filter.vegeterian]!,
          ),
          SwitchListItem(
            title: filterTitles[Filter.vegan]!,
            initState: currentFilters[Filter.vegan]!,
          ),
        ],
      ),
    );
  }
}
