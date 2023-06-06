import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';

@lazySingleton
class ScannerViewModel extends BaseViewModel {
  bool flashStatus = false;

  toggleFlash(status) {
    flashStatus = status;
    notifyListeners();
  }
}
