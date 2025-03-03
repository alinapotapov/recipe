import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(this.filePath, {super.key});

  final String filePath;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(image: NetworkImage(filePath)),
    );
  }
}
