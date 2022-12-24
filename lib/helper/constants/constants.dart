import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import "package:intl/intl.dart";
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:logger/logger.dart';

class Constants {
  static const Color primaryColor = Color(0xFF40898A);
  static const Color accentColor = Color.fromARGB(121, 207, 236, 237);
  static const Color secondaryColor = Color(0xFF000000);

  static const Color shimmerBaseColor = Color.fromARGB(255, 203, 203, 203);
  static const Color shimmerHighlightColor = Colors.white;

  // static String pstk = "pk_test_043683268da92cd71e0d30f9d72396396f2dfb1f";
  static String pstk = "pk_test_80049c5b3452471f42a2a1b972e638c7ccad240d";

  static String formatMoney(int amt) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: double.parse("${amt}.00"),
        settings: MoneyFormatterSettings(
            symbol: 'NGN',
            thousandSeparator: ',',
            decimalSeparator: '.',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    return fmf.output.withoutFractionDigits;
  }

  static String formatMoneyFloat(double amt) {
    MoneyFormatter fmf = MoneyFormatter(
        amount: amt,
        settings: MoneyFormatterSettings(
            symbol: 'NGN',
            thousandSeparator: ',',
            decimalSeparator: '.',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 3,
            compactFormatType: CompactFormatType.short));
    return fmf.output.withoutFractionDigits;
  }

  static nairaSign(context) {
    Locale locale = Localizations.localeOf(context);
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format;
  }

  static toast(String message) {
    Fluttertoast.showToast(
      msg: "" + message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  //Account Page
  static final accScaffoldKey = GlobalKey<ScaffoldState>();
  static const riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');

  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write("ff");
    buffer.write(hexString.replaceFirst("#", ""));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool loadingHashSign = true}) => "";
}
