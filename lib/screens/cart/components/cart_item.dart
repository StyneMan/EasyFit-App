import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/model/cart/cart_model.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final CartModel model;
  var data;
  CartItem({Key? key, required this.model, this.data}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<CartNotifier>(context);
    // final user = Provider.of<UserNotifier>(context);

    return
        // user.carts == null
        //     ? CartShimmer()
        //     :
        SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Constants.accentColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Center(
              child: Image.asset(
                '${widget.model.image ?? widget.data['image']}',
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/images/bottle_placeholder.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.21,
                ),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.21,
              ),
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.48,
                          child: Text(
                            '${widget.model.name ?? widget.data['name']}'
                                        .length >
                                    32
                                ? '${widget.model.name ?? widget.data['name']}'
                                        .substring(0, 30) +
                                    "..."
                                : '${widget.model.name ?? widget.data['name']}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${widget.model.productId ?? widget.data['productId']}',
                          style: const TextStyle(
                            color: Color(0xFFBEC3D5),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(widget.model.price)}'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // cart.removeCartItem(widget.model);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (widget.model.quantity > 1) {
                              // cart.decreaseQuantity(widget.model);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0.0),
                            color: widget.model.quantity == 1
                                ? Constants.accentColor
                                : Constants.primaryColor,
                            child: const Text(
                              "-",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("${widget.model.quantity}"),
                        ),
                        InkWell(
                          onTap: () {
                            // cart.increaseQuantity(widget.model);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0.0),
                            color: Constants.primaryColor,
                            child: const Text(
                              "+",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
