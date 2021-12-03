import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'take_picture_page.dart';
//import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:http/http.dart' as http;
import 'displaycheque.dart';

class BankDetails {
  String address;
  String branch;
  String city;
  String contact;
  String district;
  String state;
  BankDetails(
      {@required this.address,
      @required this.branch,
      @required this.city,
      @required this.contact,
      @required this.district,
      @required this.state});
}

class Result {
  String accNo;
  String bank;
  String ifsc;
  String micr;
  BankDetails bankDetails;
  List<String> name;

  Result(
      {@required this.accNo,
      @required this.bank,
      @required this.ifsc,
      @required this.micr,
      this.bankDetails,
      @required this.name});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      accNo: json['accNo'] as String,
      bank: json['bank'] as String,
      ifsc: json['ifsc'] as String,
      micr: json['micr'] as String,
      //bankDetails: json['bankDetails'] as BankDetails,
      name: json['name'].cast<String>()
    );
  }
}

class Root {
  String requestId;
  Result result;
  int statusCode;
  Root({
    @required this.requestId,
    @required this.result,
    @required this.statusCode,
  });

  factory Root.fromJson(Map<String, dynamic> json) {
    return Root(
        requestId: json['requestId'] as String,
        result: Result.fromJson(json['result']),
        statusCode: json['statusCode'] as int);
  }
}

class CamHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _BaseMe {
  String fileB64;

  Map<String, dynamic> toJson() => {'fileB64': fileB64};
}

class _HomePageState extends State<CamHomePage> {
  String _path = null;
  bool _chkbutton = false;
  bool _chktext = false;
  var name1Controller = TextEditingController();

  void _httphit() async {
    File imageResized;

    //imageResized = await FlutterNativeImage.compressImage(_path,
    imageResized = new File(_path);
    //quality: 100, targetWidth: 120, targetHeight: 120);

    setState(() {
      List<int> imageBytes = imageResized.readAsBytesSync();
      var photoBase64 = base64Encode(imageBytes);
      print(photoBase64);

      _BaseMe _bb = new _BaseMe();
      _bb.fileB64 = photoBase64;
      String jsonUser = jsonEncode(_bb);
      print("----------------" + jsonUser + "----------------");
      //name1Controller.text = "--"+jsonUser+"--";
      http.post(
        Uri.parse('https://testapi.karza.in/v3/ocr/cheque'),
        body: jsonUser,
        headers: {'x-karza-key': 'cWB8WoVWt6YRP8y6'},
      ).then((http.Response response) {
        print(response.body);

        if (response.statusCode == 200) {
          
          var posts = Root.fromJson(jsonDecode(response.body));

          if (posts.statusCode == 101) {
            var accno = posts.result.accNo;
            var bank = posts.result.bank;
            var ifsc = posts.result.ifsc;
            var name = posts.result.name;

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayCheque(
                      accno: accno, bank: bank, ifsc: ifsc, name: name),
                ));
          }
        } else {
          name1Controller.text = response.body;
        }
      });
    });
  }

  void _showPhotoLibrary() async {
    final file = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _path = file.path;
      _chkbutton = true;
      _chktext = true;
    });
  }

  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));

    setState(() {
      _path = result;
      _chkbutton = true;
      _chktext = true;
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCamera();
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: <Widget>[
        Expanded(
          child: _path == null
              ? Image.asset("assets/place-holder.png")
              : Image.file(File(_path)),
        ),
        FlatButton(
          child: Text("Take Picture", style: TextStyle(color: Colors.white)),
          color: Colors.green,
          onPressed: () {
            _showOptions(context);
          },
        ),
        if (_chkbutton)
          FlatButton(
            child: Text("done", style: TextStyle(color: Colors.white)),
            color: Colors.green,
            onPressed: () {
              _httphit();
            },
          ),
        if (_chktext)
          Expanded(
            child: TextField(
              controller: name1Controller,
              maxLines: 100000,
            ),
          )
      ]),
    ));
  }
}
