import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.campaign,
          size: 28,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            Icons.person,
            size: 28,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
