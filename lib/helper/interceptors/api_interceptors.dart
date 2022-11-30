import 'dart:io';

// import 'package:zema/helper/state/state_controller.dart';
import 'package:easyfit_app/screens/auth/login/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http_interceptor/http_interceptor.dart';
// import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easyfit_app/helper/state/state_manager.dart';

// import '../../util/preference_manager.dart';

class MyApiInterceptor implements InterceptorContract {
  // late PreferenceManager manager;

  final _controller = Get.find<StateController>();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final cache = await SharedPreferences.getInstance();

      data.headers[HttpHeaders.contentTypeHeader] = "application/json";
      data.headers[HttpHeaders.authorizationHeader] =
          "Bearer " + cache.getString("accessToken")!;
    } on SocketException catch (_) {
      _controller.setLoading(false);
      Fluttertoast.showToast(
        msg: "Check your internet connection!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      _controller.setLoading(false);
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401 || data.statusCode == 403) {
      print("LOG THIS USER OUT. SESSION EXPIRED!!!");
      Get.offAll(const Login());
    }
    return data;
  }
}
