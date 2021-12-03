import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int percentage = 0;
  String resultString = "";

  Map<String, String> requestHeaders = {
    'x-rapidapi-host': 'covid-193.p.rapidapi.com',
    'x-rapidapi-key': '1e79737ea0msh687bd9df8f3c710p139ca4jsnf383b40dc933'
    //'useQueryString': true
  };

  final name1Controller = TextEditingController();
  final name2Controller = TextEditingController();

  void _getNames({String name1, String name2}) async {
    final response = await http.get(Uri.https("covid-193.p.rapidapi.com", "countries"),
      // Send authorization headers to the backend.
      headers: requestHeaders,
    );

    final responseJson = json.decode(response.body);
    
    print('response');
    print(response.body);

    setState(() {
      resultString = responseJson['get'];
     percentage  = responseJson['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: name1Controller,
              decoration: InputDecoration(
                hintText: "name 1",
              ),
            ),
            TextField(
              controller: name2Controller,
              decoration: InputDecoration(
                hintText: "name 2",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your Score is: $percentage',
            ),
            Text(
              '$resultString',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getNames(
            name1: name1Controller.text,
            name2: name2Controller.text,
          );
        },
        tooltip: 'Increment',
        child: Text('Go'),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Hello Fragment 1"),
    );
  }

}*/