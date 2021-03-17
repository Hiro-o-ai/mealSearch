import 'package:flutter/material.dart';

import './category_meals_screen.dart';
import './categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', // default は '/'
      routes: {
        // デフォルトで'/'に設定したrootが動くようになっている
        // そのためhome:で指定しても、こちらが優先されるので注意が必要
        '/': (ctx) => CategoriesScreen(),
        // /を付ける理由はwebAppの変更の対応に必要だから
        // CategoryMealsScreenにはpushNamedのargumentsを利用して変数を渡している
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        // '/category-meal': (ctx) => CategoryMealsScreen(),
      },
    );
  }
}
