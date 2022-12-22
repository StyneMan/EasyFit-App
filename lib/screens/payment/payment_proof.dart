import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/drawer/custom_drawer.dart';
import '../../components/text_components.dart';
import '../../helper/constants/constants.dart';
import '../../helper/preference/preference_manager.dart';
import '../../helper/state/state_manager.dart';

class PaymentProof extends StatefulWidget {
  final PreferenceManager manager;
  const PaymentProof({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  State<PaymentProof> createState() => _PaymentProofState();
}

class _PaymentProofState extends State<PaymentProof> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = Get.find<StateController>();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    _controller.setLoading(true);
    Future.delayed(const Duration(seconds: 3), () {
      _controller.setLoading(false);
      Navigator.of(context).pop();
    });
    // _controller.setLoading(true);
    // var currUser = await FirebaseAuth.instance.currentUser;
    // if (userId != null) {
    //   if (_photo == null) return;
    //   final destination = 'proofs/$userId';

    //   try {
    //     final ref = firebase_storage.FirebaseStorage.instance
    //         .ref(destination)
    //         .child('${DateTime.now().millisecondsSinceEpoch}/');
    //     await ref.putFile(_photo!);
    //     final fileUrl = await ref.getDownloadURL();

    //     listMap[0]['cart']?.forEach((element) async {
    //       DateTime currDate = DateTime.now(); //DateTime
    //       Timestamp myTimeStamp = Timestamp.fromDate(currDate);
    //       final tm = DateTime.now();

    //       await FirebaseFirestore.instance
    //           .collection("proofs")
    //           .doc("${tm.microsecondsSinceEpoch}")
    //           .set({
    //         "customerId": userId,
    //         "id": tm.microsecondsSinceEpoch,
    //         "orderNo": "${tm.millisecondsSinceEpoch}",
    //         // "name": "${userData?.name}",
    //         "image": fileUrl,
    //         "product": element['name'],
    //         "price": element['price'],
    //         "amount": cart.totalCartPrice,
    //         "quantity": element['quantity'],
    //         "status": "Pending",
    //         "createdAt": myTimeStamp,
    //       });
    //     });
    //     //Now save to firestore
    //     setState(() {
    //       _photo = null;
    //     });
    //     _controller.setLoading(false);
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => PaymentSuccessful(manager: widget.manager),
    //       ),
    //     );
    //   } catch (e) {
    //     _controller.setLoading(false);
    //     print('error occured::: $e');
    //   }
    // }
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
                Navigator.pop(context);
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
          text: "payment proof".toUpperCase(),
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
          manager: widget.manager,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Constants.accentColor,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: const EdgeInsets.all(48.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                        child: const Icon(Icons.camera, color: Colors.white),
                        onPressed: () {
                          imgFromCamera();
                        },
                      ),
                      const SizedBox(height: 8.0),
                      const Text("Camera"),
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    children: [
                      FloatingActionButton(
                        child: const Icon(Icons.image, color: Colors.white),
                        onPressed: () {
                          imgFromGallery();
                        },
                      ),
                      const SizedBox(height: 8.0),
                      const Text("Gallery"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            child: SizedBox(
              width: double.infinity,
              child: _photo != null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: Image.file(
                        _photo!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: Image.asset(
                        "assets/images/placeholder.png",
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _photo != null
                  ? () {
                      // print("dataKL::: ${widget.manager.getUserId()}");
                      uploadFile();
                    }
                  : null,
              child: const Text("Upload Proof"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(18.0),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
