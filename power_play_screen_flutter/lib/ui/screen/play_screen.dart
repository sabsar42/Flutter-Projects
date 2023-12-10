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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: FirstScreen(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: SecondScreen(),
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
