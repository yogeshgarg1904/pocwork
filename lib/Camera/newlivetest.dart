import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:guardian_liveness/guardian_liveness.dart';

class DemoLivenessApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
      ],
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

var name1Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GuardianLiveness.isDeviceSupportLiveness().then((isSupported) async {
        try {
          await GuardianLiveness.initLiveness();
          setState(() {
            _canDetectLiveness = isSupported;
          });
        } catch (e) {
          _showError(e,);
        }
      },);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Liveness App',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0,),
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints.loose(
                    Size.square( _bitmap != null ? 300.0 : 0.0, ),
                  ),
                  child: Builder(
                    builder: (_) {
                      if (_bitmap == null) {
                        return Container();
                      }
                      return Image.memory(_bitmap, fit: BoxFit.cover,);
                    },
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text("Start Liveness Detection",),
              onPressed: _canDetectLiveness ? _startLivenessDetection : null,
            ),
            _canDetectLiveness ? Container() : Padding(
              padding: const EdgeInsets.all(16.0,),
              child: Text(
                "Your device doesn't support Liveness Detection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0, color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
            child: TextField(
              controller: name1Controller,
              maxLines: 100000,
            ),
          ),
          ],
        ),
      ),
    );
  }

  bool _canDetectLiveness = false;
  Uint8List _bitmap;

  void _startLivenessDetection() {
    GuardianLiveness.detectLiveness().then((result) {
      print("Base64 Result: ${result.base64String}",);
      setState(() {
        _bitmap = result.bitmap;
        name1Controller.text = result.base64String;
      });
    },).catchError((e) {
      _showError(e,);
    },);
  }

  void _showError(var e) {
    if (e is LivenessException) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.code,),
          content: Text(e.message,),
          actions: <Widget>[
            FlatButton(
              child: Text("Close",),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(LivenessException.ERROR_UNDEFINED,),
          content: Text(e.toString(),),
          actions: <Widget>[
            FlatButton(
              child: Text("Close",),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}