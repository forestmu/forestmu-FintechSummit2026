import 'package:flutter/material.dart';
import 'package:mingle/styles/colors.dart';

class LoginRegisterBg extends StatelessWidget {

  final Widget child;

  const LoginRegisterBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: accent),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 0, horizontal: 36),
        child: child),
      ],
    );
  }
}

/// Custom clipper for the wave shape
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    // Start at top-left
    path.lineTo(0, size.height * 0.5);

    // Curve: down and then up to right
    path.quadraticBezierTo(
      size.width * 0.20,
      size.height * 0.6,
      size.width * 0.6,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.90,
      size.height * 0.28,
      size.width,
      size.height * 0.5,
    );

    // Right edge and top
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}