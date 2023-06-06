import 'package:injectable/injectable.dart';
import 'package:qrapp/ui/views/base_viewmodel.dart';

@LazySingleton()
class AdminLoginScreenViewModel extends BaseViewModel {
  var emailValidation = false;

  toggleEmailValidation(val) {
    emailValidation = val;
    notifyListeners();
  }
}
