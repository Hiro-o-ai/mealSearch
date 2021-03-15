import 'package:flutter/material.dart';

class CatergoryItem extends StatelessWidget {
  final String title;
  final Color color;

  CatergoryItem(this.title, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(title),
      decoration: BoxDecoration(
        // グラデーション
        gradient: LinearGradient(
          colors: [
            // opacityは不透明度
            color.withOpacity(0.7),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // .circularがあるのでconstが使えない
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
