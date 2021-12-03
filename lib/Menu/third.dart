import 'package:flutter/material.dart';
import './Tabs/tabs_page.dart';

//https://github.com/PaulHalliday/flutter_indexed_stack_tab_view

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}