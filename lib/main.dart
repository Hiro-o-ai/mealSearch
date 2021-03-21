import 'package:flutter/material.dart';

import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

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
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      // 登録されていない画面遷移がある時に機能する（例えば、MealDetailScreen.routeNameの行をコメントアウトするなどの場合）
      // ただし、これはroutesに登録されているとこちらは使用されない
      onGenerateRoute: (settings) {
        // こんな使い方が有効
        // if (settings.name == '/meal_detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // print(settings.arguments);
        // return MaterialPageRoute(
        //   builder: (ctx) => CategoriesScreen(),
        // );
      },
      // エラーが発生した時に使用されるroute
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      // onGenerateRouteは未登録の名前付きルートがあった場合に利用され、onUnknownRouteはonGenerateRouteにもないか、エラーが発生した時に利用される
    );
  }
}
