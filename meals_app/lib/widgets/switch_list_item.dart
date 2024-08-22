import 'package:flutter/material.dart';
import 'package:meals_app/screens/filters_screen.dart';

class SwitchListItem extends StatefulWidget {
  final String title;
  final void Function(String title, bool selected) onSwicth;
  bool initState;

  SwitchListItem({
    super.key,
    required this.title,
    required this.onSwicth,
    required this.initState,
  });

  @override
  State<StatefulWidget> createState() => _SwitchListItem();
}

class _SwitchListItem extends State<SwitchListItem> {
  @override
  Widget build(BuildContext context) => SwitchListTile(
        activeColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: const EdgeInsets.only(left: 32, right: 24),
        value: widget.initState,
        onChanged: (isChecked) {
          widget.onSwicth(widget.title, isChecked);
          setState(
            () {
              widget.initState = isChecked;
            },
          );
        },
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Text(
          'Only include ${widget.title} meals',
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
}
