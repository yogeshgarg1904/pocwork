import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart';
import 'dart:convert';

class ChekBoxFile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Location(),
    );
  }
}

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  //initState
  bool selected = false;
  var userStatus = List<bool>();


  Future<List<User>> _getUsers() async {
    //var data = await http.get("http://www.json-generator.com/api/json/get/cdjVKlMEde?indent=2");
    var data = await get(Uri.http(
        "www.json-generator.com", "/api/json/get/cdjVKlMEde", {"indent": "2"}));

    var jsonData = json.decode(data.body);
  List<User> users = [];
    

    for (var u in jsonData) {
      User user =
          User(u["index"], u["about"], u["name"], u["email"], u["picture"]);

      users.add(user);
      userStatus.add(false);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Select City'),
        ),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                child: Container(
                  //height: 200,
                  child: FutureBuilder(
                    future: _getUsers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      print(snapshot.data);
                      if (snapshot.data == null) {
                        return Container(
                            child: Center(child: Text("Loading...")));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(snapshot.data[index].picture),
                              ),
                              //title: Text(snapshot.data[index].name),
                              title: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a search term'),
                              ),
                              subtitle: Text(snapshot.data[index].email),

                              trailing: Checkbox(
                                  value: userStatus[index],
                                  onChanged: (bool val) {
                                    setState(() {
                                      userStatus[index] = !userStatus[index];
                                    });
                                  }),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(snapshot.data[index])));
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  child: Text('Camera'),
                  onPressed: () {
                    var num=0;
                    for (var age in userStatus) {
                      if(age){
                        print('this number $num checked');
                      }else{
                      print('this number $num not checked');
                      }
                      num++;
                    }
                  },
                ),
              ),
            ]));
  }
}

class DetailPage extends StatelessWidget {
  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(user.name),
    ));
  }
}

class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}
