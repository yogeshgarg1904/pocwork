import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:clipboard/clipboard.dart';
import 'package:first_app/firebaseml/api/firebase_ml_api.dart';
import 'package:first_app/firebaseml/widget/text_area_widget.dart';
import 'package:first_app/helper/ase-helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'controls_widget.dart';

class TextRecognitionWidget extends StatefulWidget {
  const TextRecognitionWidget({
    Key key,
  }) : super(key: key);

  @override
  _TextRecognitionWidgetState createState() => _TextRecognitionWidgetState();
}

class _TextRecognitionWidgetState extends State<TextRecognitionWidget> {
  String text = '';
  File image;

  MyEncrption myExt = MyEncrption();

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          children: [
            Expanded(child: buildImage()),
            const SizedBox(height: 16),
            ControlsWidget(
              onClickedPickImage: pickImage,
              onClickedScanText: scanText,
              onClickedClear: clear,
            ),
            const SizedBox(height: 16),
            TextAreaWidget(
              text: text,
              onClickedCopy: copyToClipboard,
            ),
          ],
        ),
      );

  Widget buildImage() => Container(
        child: image != null
            ? Image.file(image)
            : Icon(Icons.photo, size: 80, color: Colors.black),
      );

  Future pickImage() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    setImage(File(file.path));
  }

  Future scanText() async {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    final text = await FirebaseMLApi.recogniseText(image);
    setText(text);

    Navigator.of(context).pop();
  }

  Future<Null> testme() async {
    final queryParameters = {
      'langCode': 'en',
      'requestId': '12345',
    };

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'USER_ACCESS_TOKEN': 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMjIwIiwiaWF0IjoxNjI3ODg3NDYxLCJleHAiOjE2Mjg0OTIyNjF9.-IeSbKjToPnalwNdiImmMKrm7eqn5vh3G9mICgwrnXl_mPOtcf65bz62qQOzQmx1bot8M7I_bMGk0zmBqEGrog'
      //'useQueryString': true
    };
    Map map = {'deviceId': 'cccyt1234321'};
    final response = await http.post(
      Uri.http(
          "3.108.237.194:8083", "/madmin/utility/getMenus", queryParameters),
      body: json.encode(map),
      //headers: {'Content-Type': 'application/json'},
      headers: requestHeaders,
    );

    print(response.body);
    if (response.statusCode == 200) {
      print('sucess');
      final welcome = welcomeFromJson(response.body);
      print('element '+ welcome.finalMap.guestMenu[0].subMenu[0].id.toString());


      print('element-1 '+ welcome.finalMap.guestMenu[welcome.finalMap.guestMenu.length-1].name);

      if(welcome.finalMap.guestMenu[welcome.finalMap.guestMenu.length-1].subMenu == null)
      {
        print('null hai bhai');
      }

    } else {
      print('Unable to retrieve posts');
    }
  }

  void clear() {
    //setImage(null);
    //setText('');

    ////////////////////

    testme();

    ///////////////////
  }

  void copyToClipboard() {
    if (text.trim() != '') {
      FlutterClipboard.copy(text);
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  void setText(String newText) {
    setState(() {
      text = newText;
    });
    var dt = myExt.encrypt('8888');
    myExt.decrypt(dt);
    LineSplitter ls = new LineSplitter();
    List<String> lines = ls.convert(text);

    print("---Result---");
    var ifc = "0";
    var acc = "0";
    var bakn = "0";
    for (var i = 0; i < lines.length; i++) {
      if (ifc == "0") {
        if (lines[i].contains('IFS Code:')) {
          print(
              'ifcs code  is --- :${lines[i].substring(lines[i].indexOf("IFS Code:") + 8)}');
          ifc = "1";
        }
      }
      if (acc == "0") {
        if (_isNumeric(lines[i])) {
          print('account no is --- :${lines[i]}');
          acc = "1";
        }
      }
      if (acc == "0") {
        if (lines[i].contains('No')) {
          print(
              'account no is --- :${lines[i].substring(lines[i].indexOf("No") + 3)}');
          acc = "1";
        }
      }
      if (bakn == "0") {
        if (lines[i].contains('bank') || lines[i].contains('bant')) {
          print('bank name is --- :${lines[i]}');
          bakn = "1";
        }
      }
      //print('Line $i: ${lines[i]}');

    }
  }
}
