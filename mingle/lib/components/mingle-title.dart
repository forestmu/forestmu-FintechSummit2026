import 'package:flutter/material.dart';
import 'package:mingle/styles/colors.dart';

class mingleTitle extends StatelessWidget {

  final double? size;

  const mingleTitle({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Text("mingle", style: TextStyle(fontFamily: 'Notable', fontSize: size ?? 16, color: secondary),);
  }
}