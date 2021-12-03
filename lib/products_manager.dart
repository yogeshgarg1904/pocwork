import 'package:first_app/testme.dart';
import 'package:flutter/material.dart';

import './products.dart';
import './mainmenu.dart';
import 'CAMS.dart';
import 'Camera/Camerahome.dart';
import 'Camera/flutter_ocr.dart';
import 'Camera/liveliness.dart';
import 'Camera/newlivetest.dart';
import 'Login/NewLogin.dart';
import 'Login/NewScreens/CenterTab.dart';
import 'Map/mapfile.dart';
import 'checkbox/chekboxfile.dart';
import 'checkbox/kyc_page.dart';
import 'firebaseml/firebase_ml.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager(this.startingProduct);

  @override
  State<StatefulWidget> createState() {
    return _productManagerState();
  }
}

class _productManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    _products.add(widget.startingProduct);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple),
      home: Scaffold(
          appBar: AppBar(
            title: Text('EasyList'),
          ),
          body: Wrap(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      _products.add('Advanced Food Tester');
                    });
                  },
                  child: Text('Add products'),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Authenticate'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Camera'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CamHomePage()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Maps'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMaps()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('CAMS'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAppCAMS()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('selfi'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DemoLivenessApp()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('checkbox'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChekBoxFile()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('new login'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewLogin()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('tab center'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('flutter ocr'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlutterOCR()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('firebase ML'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyFireBaseML(title: 'recognistion')),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Start KYC'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerticalExample()),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Custome Menu'),
                  onPressed: () {
                    // Navigate to second route when tapped.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestMe()),
                    );
                  },
                ),
              ),
              Products(_products)
            ],
          )),
    );
  }
}
