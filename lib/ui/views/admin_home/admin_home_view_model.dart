import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';

@lazySingleton
class AdminHomeViewModel extends BaseViewModel {
  List data = [
    {"role": "admin", "user": [], "value": "Admins"},
    {"role": "user", "user": [], "value": "Users"},
  ];
}
