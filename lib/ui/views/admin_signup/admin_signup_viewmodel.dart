import 'package:injectable/injectable.dart';
import 'package:qrapp/ui/views/base_viewmodel.dart';

@LazySingleton()
class AdminSignUpViewModel extends BaseViewModel {
  bool emailValidation = false;

  toggleEmailValidation(val) {
    emailValidation = val;
    notifyListeners();
  }
}
