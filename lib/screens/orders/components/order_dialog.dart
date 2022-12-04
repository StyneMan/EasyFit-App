import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/model/orders/ordersmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDialog extends StatelessWidget {
  final OrdersModel order;
  const OrderDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Text(
                    "ORDER INFORMATION",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Colors.red,
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    order.product.image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.33,
                    height: MediaQuery.of(context).size.width * 0.33,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  "LOW CI",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${order.product.name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${Constants.nairaSign(context).currencySymbol} ${Constants.formatMoney(order.product.price)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Constants.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).pop();
                    // pushNewScreen(
                    //   context,
                    //   screen: BuyAgain(
                    //       productId: model?.name ?? data['productId'],
                    //       manager: manager),
                    // );
                  },
                  child: const Text('BUY AGAIN'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(text: 'Order Number: ', fontSize: 14),
                    TextPoppins(
                      text: "${order.orderNo}",
                      fontSize: 14,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(text: 'Order Date: ', fontSize: 14),
                    TextPoppins(
                      text: "${order.createdAt}",
                      fontSize: 14,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(text: 'Delivery Fee: ', fontSize: 14),
                    TextPoppins(
                      text: "${900}",
                      fontSize: 14,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(text: 'Payment Method: ', fontSize: 14),
                    TextPoppins(
                      text: "Bank Transfer",
                      fontSize: 14,
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(
                      text: "Name: ",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    TextPoppins(
                      text: "John Doe",
                      fontSize: 12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextPoppins(
                      text: "Address: ",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextPoppins(
                        text: "Plot 24 Abuja Lane, Demo Address",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextPoppins(
                      text: "Phone: ",
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    TextPoppins(
                      text: "08093869330",
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Stack(
    //   children: [
    //     Stack(
    //       children: [
    //         Positioned(
    //           top: -20,
    //           left: 50,
    //           right: 50,
    //           child: Center(
    //             child: ClipOval(
    //               child: Container(
    //                 width: 36,
    //                 height: 36,
    //                 color: Colors.red,
    //                 child: const Center(
    //                   child: Icon(
    //                     Icons.close,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Container(
    //       width: double.infinity,
    //       color: Constants.primaryColor,
    //       child: Card(
    //         // margin: const EdgeInsets.all(16.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Container(
    //               padding: const EdgeInsets.all(10.0),
    //               color: Colors.grey.withOpacity(0.5),
    //               width: double.infinity,
    //               child: Center(
    //                 child: TextPoppins(
    //                   text: "ORDER INFORMATION",
    //                   fontSize: 14,
    //                   color: Constants.primaryColor,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 8.0,
    //             ),
    //             ClipOval(
    //               child: Image.asset(
    //                 order.product.image,
    //                 fit: BoxFit.cover,
    //                 width: MediaQuery.of(context).size.width * 0.33,
    //                 height: MediaQuery.of(context).size.width * 0.33,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
