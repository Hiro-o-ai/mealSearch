import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  // @requiredが必要な時は({})をコンストラクターで使用する
  // @requiredはmaterial.dartがないとダメ
  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
