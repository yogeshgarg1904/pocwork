import 'package:flutter/material.dart';
import './home_page.dart';
import './search_page.dart';
import './shop_page.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: ShopPage(),
          icon: Icon(Icons.shopping_basket),
          title: Text("Shop"),
        ),
        TabNavigationItem(
          page: SearchPage(),
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
      ];
}