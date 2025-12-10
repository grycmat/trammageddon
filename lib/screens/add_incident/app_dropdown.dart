import 'package:flutter/material.dart';

class AppDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;

  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
    required this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  hint,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
              icon: const SizedBox.shrink(),
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              items: items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(itemLabelBuilder(item)),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              selectedItemBuilder: (BuildContext context) {
                return items.map((T item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        itemLabelBuilder(item),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ),
          Positioned(
            right: 15,
            top: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
