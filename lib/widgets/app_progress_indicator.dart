import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 26),
        child: SizedBox(
          width: 50,
          height: 50,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
