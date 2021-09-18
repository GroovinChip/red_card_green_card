import 'package:flutter/material.dart';

class RedCard extends StatelessWidget {
  const RedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width / 1.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
