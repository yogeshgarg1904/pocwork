import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class FlutterOCR extends StatefulWidget {

  @override
  _TakePicturePageState createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<FlutterOCR> {
  int _camera = FlutterMobileVision.CAMERA_BACK;
  String _txt = "Sample";
  //var name1Controller = TextEditingController();

  bool isInitialize = false;
  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      isInitialize  = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.red,
        buttonColor: Colors.red
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter ocr'),
        ),
        body: Center(
          child: new ListView(
            children: <Widget>[
              new Text(_txt),
              new RaisedButton(
                onPressed: _read,
                child: new Text('start scanning'),
                ),
                /*Expanded(
                  child: TextField(
                  controller: name1Controller,
                  maxLines: 10,
            ),
          )*/
            ],
          ),
        )
        ,
      ),
    );
  }
//https://medium.com/flutterworld/ocr-using-flutter-6f5765af49a6
//https://pub.dev/packages/flutter_mobile_vision/example
//https://pub.dev/packages/tesseract_ocr/example
//-----------https://www.youtube.com/watch?v=fmW-SWum5MI----------------
//-----------https://medium.com/flutterdevs/ocr-in-flutter-5144ed361239----------
  Future<Null> _read() async{
    List<OcrText> texts = [];
     //var concatenate = StringBuffer();
    try{
      texts = await FlutterMobileVision.read(
        camera: _camera,
        waitTap: true,
        multiple: true,
      );
      setState(() {
        //_txt = texts[0].value;
        for(OcrText dt in texts)
        {
            _txt += dt.value + ",,";
        }
        //name1Controller.text = texts[0].value;
        //name1Controller.text = texts.join(",,");
        /*texts.forEach((item){
    concatenate.write(item);
  });*/
  //name1Controller.text = concatenate.toString();
      });
    }
    on Exception{
      texts.add(new OcrText('fail to recognise'));
    }
  }

}