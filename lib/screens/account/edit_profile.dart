import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/picker/img_picker.dart';
import '../../components/text_components.dart';
import '../../forms/profile/editprofileform.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';
import '../cart/cart.dart';

class EditProfile extends StatefulWidget {
  final PreferenceManager manager;
  const EditProfile({Key? key, required this.manager}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Get.find<StateController>();

  bool _isImagePicked = false;
  var _croppedFile;

  _onImageSelected(var file) {
    setState(() {
      _isImagePicked = true;
      _croppedFile = file;
    });
    print("VALUIE::: :: $file");
  }

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
              width: 4.0,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                CupertinoIcons.arrow_left_circle_fill,
                color: Colors.black,
                size: 28,
              ),
            ),
          ],
        ),
        title: TextPoppins(
          text: "EDIT PROFILE".toUpperCase(),
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Constants.secondaryColor,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              pushNewScreen(
                context,
                withNavBar: true,
                screen: Cart(manager: widget.manager),
              );
            },
            icon: Stack(
              children: [
                const Icon(
                  CupertinoIcons.cart,
                  color: Constants.secondaryColor,
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: ClipOval(
                    child: Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                        color: Constants.secondaryColor,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: TextPoppins(
                        text: "2",
                        align: TextAlign.center,
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
          manager: widget.manager,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Center(
            child: ClipOval(
              child: _isImagePicked
                  ? Container(
                      height: 128,
                      width: 129,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Image.file(
                        File(_croppedFile),
                        errorBuilder: (context, error, stackTrace) => ClipOval(
                          child: SvgPicture.asset(
                            "assets/images/user_icon.svg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 128,
                      width: 128,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                      ),
                      child: Image.network(
                        "src",
                        errorBuilder: (context, error, stackTrace) => ClipOval(
                          child: SvgPicture.asset(
                            "assets/images/user_icon.svg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          TextButton(
            onPressed: () {
              showBarModalBottomSheet(
                expand: false,
                context: context,
                topControl: ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                builder: (context) => SizedBox(
                  height: 144,
                  child: ImgPicker(
                    onCropped: _onImageSelected,
                  ),
                ),
              );
            },
            child: Center(
              child: TextPoppins(
                text: "Change Picture",
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          const EditProfileForm()
        ],
      ),
    );
  }
}
