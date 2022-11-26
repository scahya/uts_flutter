import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 5,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
      itemBuilder: (BuildContext context, int index) => Icon(
        Icons.person,
        size: 150,
      ),
    );
  }
}
