import 'package:flutter/material.dart';

import 'dummy_data.dart';
import 'screens/filter_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String, bool> filterData) {
    setState(
      () {
        _filters = filterData;

        _availableMeals = DUMMY_MEALS.where(
          (meal) {
            if (_filters['gluten'] && !meal.isGlutenFree) {
              return false;
            }
            if (_filters['lactose'] && !meal.isLactoseFree) {
              return false;
            }
            if (_filters['vegan'] && !meal.isVegan) {
              return false;
            }
            if (_filters['vegetarian'] && !meal.isVegetarian) {
              return false;
            }
            return true;
          },
        ).toList();
      },
    );
  }

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
        '/': (ctx) => tabsScreen(),
        // /を付ける理由はwebAppの変更の対応に必要だから
        // CategoryMealsScreenにはpushNamedのargumentsを利用して変数を渡している
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        // '/category-meal': (ctx) => CategoryMealsScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FilterScreen.routeName: (ctx) => FilterScreen(_setFilters, _filters),
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
          builder: (ctx) => tabsScreen(),
        );
      },
      // onGenerateRouteは未登録の名前付きルートがあった場合に利用され、onUnknownRouteはonGenerateRouteにもないか、エラーが発生した時に利用される
    );
  }
}
