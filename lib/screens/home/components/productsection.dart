import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/products/products.dart';
import 'package:easyfit_app/screens/product/components/productcard.dart';
import 'package:flutter/material.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 18) / 2.60;
    final double itemWidth = size.width / 2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPoppins(
          text: "The Chef's Special",
          fontSize: 13,
        ),
        const SizedBox(
          height: 10.0,
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => ProductCard(
            product: productList[index],
          ),
          itemCount: productList.length,
        ),
      ],
    );
  }
}
