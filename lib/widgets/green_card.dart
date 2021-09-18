import 'package:flutter/material.dart';

class GreenCard extends StatelessWidget {
  const GreenCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width / 1.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
