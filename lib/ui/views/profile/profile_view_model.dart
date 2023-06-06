import 'dart:convert';

import 'package:injectable/injectable.dart';
import '../../../core/models/users.dart';
import '../base_viewmodel.dart';

@lazySingleton
class ProfileViewModel extends BaseViewModel {
  Users user = Users();
  final jsonEncoder = const JsonEncoder();

  getCurrentUser(value) {
    var map = jsonEncoder.convert(value);
    user = Users.fromJson(json.decode(map));
    notifyListeners();
  }
}
