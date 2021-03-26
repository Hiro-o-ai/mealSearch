import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(this.favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // actionやwidgetなども入れることができるので、場合分けも可能となる
  // final List<Map<String, Object>> _pages = [
  // {
  //   'page': CategoriesScreen(),
  //   'title': 'Categories',
  // },
  // {
  //   'page': FavoritesScreen(widget.favoriteMeals),
  //   'title': 'Your Favorite',
  // },
  // ];

  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  // widget.favoriteMealsがinitに使用しないとエラーとなるため
  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Your Favorite',
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        // _selectedPageの()に自動でtabのindexが入るようになっている
        // 理由は不明
        onTap: _selectedPage,
        // ただ下記のようになっていると考えられる
        // つまり勝手に変数が存在すれば渡すということかも？
        // onTap: (index) => _selectedPage(index),
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorite'),
          ),
        ],
      ),
    );
  }
}

// 上にタブがあるver
// return DefaultTabController(
//       length: 2,
//       // 初期のタブ決め、0が一番目
//       // initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Meals'),
//           bottom: TabBar(
//             tabs: <Widget>[
//               Tab(
//                 icon: Icon(
//                   Icons.category,
//                 ),
//                 text: 'Categories',
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.star,
//                 ),
//                 text: 'Favorites',
//               )
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             CategoriesScreen(),
//             FavoritesScreen(),
//           ],
//         ),
//       ),
//     );
