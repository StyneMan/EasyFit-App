import 'package:easyfit_app/components/text_components.dart';
import 'package:easyfit_app/helper/constants/constants.dart';
import 'package:easyfit_app/helper/preference/preference_manager.dart';
import 'package:easyfit_app/model/drawer/drawermodel.dart';
import 'package:easyfit_app/screens/account/account.dart';
import 'package:easyfit_app/screens/home/home.dart';
import 'package:easyfit_app/screens/marketers/marketers.dart';
import 'package:easyfit_app/screens/orders/orders.dart';
import 'package:easyfit_app/screens/plan/mealplan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatefulWidget {
  final PreferenceManager manager;
  const CustomDrawer({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<DrawerModel> drawerList = [];
  bool _isLoggedIn = true;
  var user;
  var listMap;
  var _list, _loader, _controller;

  _initAuth() async {
    // final prefs = await SharedPreferences.getInstance();
    // _isLoggedIn = prefs.getBool('loggedIn') ?? false;
    if (_isLoggedIn) {
      setState(() {
        drawerList = [
          // DrawerModel(
          //   icon: 'assets/images/home_drawer.svg',
          //   title: 'Home',
          //   isAction: false,
          //   widget: Home(
          //       // manager: widget.manager,
          //       ),
          // ),
          // DrawerModel(
          //   icon: 'assets/images/orders_drawer.svg',
          //   title: 'Orders',
          //   isAction: false,
          //   widget: Orders(
          //     manager: widget.manager,
          //   ),
          // ),
          // DrawerModel(
          //   icon: 'assets/images/atls_drawer.svg',
          //   title: 'ATLs',
          //   isAction: true,
          // ),
          // DrawerModel(
          //   icon: 'assets/images/marketers_drawer.svg',
          //   title: 'Marketers',
          //   isAction: false,
          //   widget: const Marketers(),
          // ),
          DrawerModel(
            icon: 'assets/images/meal_plan_drawer.svg',
            title: 'Meal Plans',
            isAction: false,
            widget: MealPlan(
              manager: widget.manager,
            ),
          ),
          DrawerModel(
            icon: 'assets/images/maccount_drawer.svg',
            title: 'My Account',
            isAction: false,
            widget: Account(
              manager: widget.manager,
            ),
          ),
        ];
      });
    } else {
      // setState(() {
      //   drawerList = [
      //     DrawerModel(
      //       icon: 'assets/images/shop_drawer.svg',
      //       title: 'Shop',
      //       isAction: false,
      //       widget: AllProducts(
      //         manager: widget.manager,
      //       ),
      //     ),
      //     DrawerModel(
      //       icon: 'assets/images/drawer_blog_icon.svg',
      //       title: 'Blog',
      //       isAction: true,
      //     ),
      //     DrawerModel(
      //       icon: 'assets/images/faq_drawer.svg',
      //       title: 'FAQ\'s',
      //       isAction: false,
      //       widget: FAQs(manager: widget.manager),
      //     ),
      //     DrawerModel(
      //       icon: 'assets/images/contact_drawer.svg',
      //       title: 'Contact us',
      //       isAction: false,
      //       widget: ContactUs(
      //         manager: widget.manager,
      //       ),
      //     ),
      //   ];
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    _initAuth();

    // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    //   listMap = Provider.of<List<Map>>(context, listen: false);
    //   user = Provider.of<UserNotifier>(context, listen: false);
    // });
  }

  _logout(loader) async {
    // loader.setLoading(true);
    // Future.delayed(const Duration(seconds: 3), () {

    // });
  }

  // Future<void> _launchInBrowser(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: false,
  //       forceWebView: false,
  //       headers: <String, String>{'my_header_key': 'my_header_value'},
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.33),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 32.0, left: 24, right: 24, bottom: 1),
                    width: double.infinity,
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.175,
                    child: Center(
                      child: TextPoppins(
                        text: "Menu",
                        fontSize: 18,
                        color: Colors.black,
                        align: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                Container(
                  color: Colors.white,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return ListTile(
                        dense: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              drawerList[i].icon,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 21.0,
                            ),
                            TextPoppins(
                              text: drawerList[i].title,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: drawerList.length,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width * 0.40,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextPoppins(
                        text: "LOG OUT",
                        fontSize: 14,
                        align: TextAlign.center,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      const Icon(Icons.logout_rounded)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
          ],
        ),
      ),
    );
  }
}
