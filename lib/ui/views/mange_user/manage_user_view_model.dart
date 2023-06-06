import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';

@lazySingleton
class ManageUserViewModel extends BaseViewModel {
  String roleToggle = '';

  roleToggleModifier(String value) {
    roleToggle = value;
    notifyListeners();
  }
}
