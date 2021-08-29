import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: GridView.builder(
          // physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return GridTile(
                child: Container(
                    color: Colors.blue[200],
                    alignment: Alignment.center,
                    child: Text(products[0].title)));
          },
        ),
      ),
    );
  }
}
