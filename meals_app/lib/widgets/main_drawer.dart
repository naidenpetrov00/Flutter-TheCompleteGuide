import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String identifer) onSelectScreen;

  const MainDrawer({super.key, required this.onSelectScreen});

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.8),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.fastfood,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Cooking up!',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                onSelectScreen('meals');
              },
              leading: Icon(
                Icons.restaurant,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Meals',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
            ),
            ListTile(
              onTap: () {
                onSelectScreen('filters');
              },
              leading: Icon(
                Icons.settings,
                size: 24,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              title: Text(
                'Filters',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 24,
                    ),
              ),
            ),
          ],
        ),
      );
}
