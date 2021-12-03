import 'widget/text_recognition_widget.dart';
import 'package:flutter/material.dart';
//https://www.youtube.com/watch?v=TNKtGOZRA5o
//https://github.com/JohannesMilke/firebase_ml_text_recognition

class MyFireBaseML extends StatefulWidget {
  final String title;

  const MyFireBaseML({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MyFireBaseML> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 25),
              TextRecognitionWidget(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
}