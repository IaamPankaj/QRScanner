import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import '../../../router.gr.dart';
import '../base_viewmodel.dart';

@lazySingleton
class LoginViewModel extends BaseViewModel {
  String number = '';
  String code = '';
  bool isCodeCompatible = false;

  savedNumber(value) {
    number = value;
  }
}
