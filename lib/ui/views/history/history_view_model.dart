import 'package:injectable/injectable.dart';
import 'package:qrapp/core/models/history.dart';
import '../base_viewmodel.dart';

@lazySingleton
class HistroyViewModel extends BaseViewModel {
  List<History> historyList = [];

  setHistoryList(value) {
    historyList.add(value);
    notifyListeners();
  }
}
