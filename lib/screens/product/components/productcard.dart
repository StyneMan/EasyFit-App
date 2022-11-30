import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/data/products/products.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.175,
                  errorBuilder: (context, err, st) => Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.175,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextPoppins(
                    text: product.name.length > 19
                        ? product.name.substring(0, 16) + "..."
                        : product.name,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  TextPoppins(
                    text: product.description.length > 24
                        ? product.description.substring(0, 21) + "..."
                        : product.description,
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(product.price)}",
                        style: const TextStyle(
                          color: Constants.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ClipOval(
                        child: Container(
                          color: Constants.primaryColor,
                          padding: const EdgeInsets.all(4.0),
                          child: const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
