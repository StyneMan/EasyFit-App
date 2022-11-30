import 'dart:convert';

// import 'package:dwec_app/model/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  final BuildContext? context;
  static var prefs;

  PreferenceManager(this.context) {
    init();
  }

  // static getIstance() async {
  //   init2();
  // }

  void init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void saveAccessToken(String token) {
    prefs.setString('accessToken', token);
  }

  void setUserId(String id) {
    prefs.setString('userID', id);
  }

  void setFCMToken(String token) {
    prefs.setString('fcmToken', token);
  }

  String getFCMToken() => prefs != null ? prefs!.getString('fcmToken') : '';

  void setIsLoggedIn(bool loggenIn) {
    prefs.setBool('loggedIn', loggenIn);
  }

  bool getIsLoggedIn() => prefs!.getBool('loggedIn') ?? false;

  String getAccessToken() =>
      prefs != null ? prefs!.getString('accessToken') : '';

  String getUserId() => prefs != null ? prefs!.getString('userID') : '';

  void setUserData(String rawJson) {
    prefs!.setString('user', rawJson);
  }

  // UserProfile getUser() {
  //   final rawJson = prefs.getString('user') ?? '{}';
  //   Map<String, dynamic> map = jsonDecode(rawJson);
  //   return UserProfile.fromJson(map);
  // }

  // static Future<UserProfile> getUserStatic() async {
  //   final rawJson = await SharedPreferences.getInstance();
  //   Map<String, dynamic> map = jsonDecode(rawJson.getString('user')!);
  //   return UserProfile.fromJson(map);
  // }

  void clearProfile() {
    prefs!.remove("user");
    prefs!.remove("accessToken");
    prefs!.remove("loggedIn");
    prefs!.remove("refreshToken");
  }
}
