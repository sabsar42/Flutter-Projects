import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/main.dart';
import 'package:power_play_screen_flutter/ui/screen/SecondScreen.dart';
import 'package:power_play_screen_flutter/ui/screen/ThirdScreen.dart';

import 'FirstScreen.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final fixedColor = Color.fromRGBO(4, 4, 44, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 1, 28, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 10, 33, 1.0),
        leading: Container(
          height: 100,
          width: 100,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        title: Text(
          'Start Power Play Overs',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Power Play 1',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(170, 170, 231, 1.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FirstScreen(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Power Play 2',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(170, 170, 231, 1.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: SecondScreen(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Power Play 3',
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(170, 170, 231, 1.0),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ThirdScreen(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
