import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:qrapp/locator.dart';

@lazySingleton
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future pushReplacement(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future clearAllAndNavigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  pop([Object? result]) {
    return navigatorKey.currentState!.pop(result);
  }

  bool canPop() {
    return navigatorKey.currentState!.canPop();
  }

  showMyDialog(String title, String description) {
    return showDialog(
      barrierColor: Colors.grey.withOpacity(0.3),
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        title: Text(
          title,
        ),
        content: Text(
          description,
        ),
        actions: [
          TextButton(
              onPressed: () {
                locator<NavigationService>().pop();
              },
              child: Text(
                "ok",
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }

  showMyDialogWithNavigation(String title, String description) {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
              onPressed: () {
                pop();
                pop();
              },
              child: Text(
                "ok",
                style: TextStyle(fontSize: 18),
              ))
        ],
      ),
    );
  }

  showMyDialogWithNavigationArg(
      String title, String description, String route, Object arguments,
      {isAdditionalFunction = false, Function? additionalFunction}) {
    return showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        content: Text(description),
        actions: [
          TextButton(
              onPressed: () {
                if (isAdditionalFunction) {
                  additionalFunction!();
                  pop();
                  navigateTo(route, arguments: arguments);
                } else {
                  pop();
                  navigateTo(route, arguments: arguments);
                }
              },
              child: Text("ok"))
        ],
      ),
    );
  }
}
