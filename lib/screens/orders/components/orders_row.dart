import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/model/orders/ordersmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'order_dialog.dart';

class OrdersRow extends StatelessWidget {
  final OrdersModel order;
  final PreferenceManager manager;
  OrdersRow({
    Key? key,
    required this.order,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(21.0)),
        child: TextButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: const EdgeInsets.all(0.0),
                content: OrderDialog(
                  order: order,
                ),
              ),
            );
          },
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          color: const Color(0x1A9A031E),
                          child: Image.asset(order.product.image),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextPoppins(
                            text: "${order.product.name}",
                            fontSize: 12,
                            color: Constants.secondaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Order No: ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  "${order.orderNo}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                  ),
                                ),
                              ]),
                          Text(
                            "${order.createdAt}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(order.product.price)}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 24,
                      padding: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Center(
                        child: TextPoppins(
                          text: "VIEW ORDER",
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
