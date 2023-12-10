import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_play_screen_flutter/main.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 10, 33, 1.0),
        leading: Container(
          color: Color.fromRGBO(1, 15, 21, 1.0),
          height: 50,
          width: 50,
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
        color: Color.fromRGBO(21, 27, 52, 1.0),
        child: SizedBox(
          child:
           Column(
              children: [

                Expanded(child: FirstScreen()),
              ],
            ),

        ),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Container(
              color: Colors.black38,
              child: Center(
                child: Text('$index'),
              ),
            ),
          );
        },
      ),
    );
  }
}
