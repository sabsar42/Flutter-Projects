import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final fixedColor = Color.fromRGBO(4, 4, 44, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Container(
              color: fixedColor,
              child: Center(
                child: Text('${index + 1}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
