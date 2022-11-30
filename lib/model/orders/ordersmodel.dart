import 'package:easyfit_app/data/products/products.dart';

class OrdersModel {
  late String orderNo;
  late String createdAt;
  late Product product;

  OrdersModel({
    required this.orderNo,
    required this.product,
    required this.createdAt,
  });
}

List<OrdersModel> ordersList = [
  OrdersModel(
    createdAt: "10 NOV, 2022",
    orderNo: "14SD346",
    product: productList[0],
  ),
  OrdersModel(
    createdAt: "10 NOV, 2022",
    orderNo: "14SD346",
    product: productList[2],
  ),
  OrdersModel(
    createdAt: "10 NOV, 2022",
    orderNo: "14SD346",
    product: productList[1],
  ),
  OrdersModel(
    createdAt: "10 NOV, 2022",
    orderNo: "14SD346",
    product: productList[2],
  ),
  OrdersModel(
    createdAt: "10 NOV, 2022",
    orderNo: "14SD346",
    product: productList[1],
  ),
];
