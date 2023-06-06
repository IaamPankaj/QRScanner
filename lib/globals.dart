import 'dart:convert';
import 'dart:math';

import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static late SharedPreferences sharedPreferences;
  static String? token;
  final jsonEncoder = const JsonEncoder();
  static late LocationData currentLocation;

  static setProfile(value) async {
    await sharedPreferences.setBool('isProfileAdded', value);
  }

  static getProfile() {
    return sharedPreferences.getBool('isProfileAdded') ?? false;
  }

  convertMap(value) {
    var map = jsonEncoder.convert(value);
    return json.decode(map);
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}

class RegexConst {
  static const email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static RegExp exp =
      new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
}
