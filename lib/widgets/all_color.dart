import 'package:flutter/material.dart';

Color itemcolor = Colors.white;
Color itembgcolor = const Color.fromARGB(255, 69, 39, 160);

class BackgroundColor extends StatelessWidget {
  final Widget child;

  const BackgroundColor({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(width: 0, color: const Color.fromARGB(0, 122, 10, 10)),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 69, 39, 160),
            Color.fromARGB(255, 179, 157, 219)
          ],
        ),
      ),
      child: child,
    );
  }
}
