import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MonkeyHomePage extends StatelessWidget {
  static const platform =
      const MethodChannel('com.example.dummyapp/surveyMonkey');
  static String sessionSurveyMonkeyHash = '7G88B2X';

  Future _loadSurveyMonkey() async {
    try {
      await platform
          .invokeMethod('surveyMonkey', sessionSurveyMonkeyHash)
          .then((result) {
        Fluttertoast.showToast(
            msg: result,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _loadSurveyMonkey,
          child: Text("Load SurveyMonkey"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}