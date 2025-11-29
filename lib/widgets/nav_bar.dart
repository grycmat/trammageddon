import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trammageddon/routing/route_names.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required onTap,
  }) {
    final isSelected = selectedIndex == index;
    final color = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6);

    return InkWell(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context: context,
                icon: Icons.dashboard,
                label: 'DASHBOARD',
                index: 0,
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  context.go(RouteNames.home);
                },
              ),
              _buildNavItem(
                context: context,
                icon: Icons.emoji_events,
                label: 'RANKING',
                index: 1,
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  context.push(RouteNames.hallOfDefame);
                },
              ),
              _buildNavItem(
                context: context,
                icon: Icons.history,
                label: 'HISTORIA',
                index: 2,
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
              ),
              _buildNavItem(
                context: context,
                icon: Icons.settings,
                label: 'USTAWIENIA',
                index: 3,
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
