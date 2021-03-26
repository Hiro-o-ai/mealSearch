import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  // ここでboolは使用できない
  // bool _loadedInitData = false;
  var _loadedInitData = false;

  @override
  void initState() {
    // ModalRouteはmaterial.dartより
    // initStateにcontextを持ってくるとwidget treeが完成する前で早すぎるためエラーとなる
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryId = routeArgs['id'];
    // final categoryTitle = routeArgs['title'];
    // final displayedMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ※_loadedInitDataをしなくても求めている動作は機能している!!!
    if (!_loadedInitData) {
      // なぜここでcontextが使えるのかは不明
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      // 下記の2点にfinalがついたままだとこの中で固定化されてしまい、上部で定義した変数の中に入らない
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // これがmeal_itemではなくここで定義されているのかというと、実際に変化させる画面がここだから
  void _removeMeal(String mealId) {
    setState(() {
      // displayedMealsの中からmealIdと同じものを削除する
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
