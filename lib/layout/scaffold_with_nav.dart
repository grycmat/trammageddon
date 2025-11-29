import 'package:flutter/material.dart';
import 'package:trammageddon/widgets/nav_bar.dart';

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child, bottomNavigationBar: const NavBar());
  }
}
