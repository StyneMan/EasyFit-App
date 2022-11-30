import 'package:easyfit_app/components/drawer/custom_drawer.dart';
import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/model/orders/ordersmodel.dart';
import 'package:easyfit_app/screens/orders/components/orders_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Orders extends StatelessWidget {
  final PreferenceManager manager;
  Orders({Key? key, required this.manager}) : super(key: key);

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Constants.primaryColor,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 16.0,
            ),
            ClipOval(
              child: SvgPicture.asset(
                "assets/images/user_icon_mini.svg",
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
          ],
        ),
        title: TextPoppins(
          text: "My Orders".toUpperCase(),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Constants.secondaryColor,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (!_scaffoldKey.currentState!.isEndDrawerOpen) {
                _scaffoldKey.currentState!.openEndDrawer();
              }
            },
            icon: SvgPicture.asset(
              'assets/images/menu_icon.svg',
              color: Constants.secondaryColor,
            ),
          ),
        ],
      ),
      endDrawer: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: CustomDrawer(
          manager: manager,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemBuilder: (context, i) => OrdersRow(
          order: ordersList[i],
          manager: manager,
        ),
        itemCount: ordersList.length,
      ),
    );
  }
}
