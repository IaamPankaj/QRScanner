import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:injectable/injectable.dart';
import '../base_viewmodel.dart';
import 'package:path_provider/path_provider.dart' as p;

@lazySingleton
class AdminQrHistoryViewModel extends BaseViewModel {
  Future download2(
      Uint8List? imageFile, bool isDownload, String savePath) async {
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(
        backgroundColor: Colors.transparent,
      ));

      String path;
      Directory? dir;

      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Downloads');
        if (await dir.exists() == false) {
          dir = Directory('/storage/emulated/0/Download');
        }
      } else {
        dir = await p.getDownloadsDirectory();
      }

      path = dir!.path;

      File file = await File('$path/$savePath.jpg').create(recursive: true);
      var raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(imageFile!);

      await raf.close();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
