import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';

class SwitchListItem extends ConsumerStatefulWidget {
  final String title;
  final bool initState;

  const SwitchListItem({
    super.key,
    required this.title,
    required this.initState,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SwitchListItem();
}

class _SwitchListItem extends ConsumerState<SwitchListItem> {
  bool _currState = false;

  @override
  void initState() {
    super.initState();
    _currState = widget.initState;
  }

  @override
  Widget build(BuildContext context) => SwitchListTile(
        activeColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: const EdgeInsets.only(left: 32, right: 24),
        value: _currState,
        onChanged: (isChecked) {
          _currState = isChecked;
          ref
              .read(filterProvider.notifier)
              .setFilterByTitle(widget.title, isChecked);
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
