// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:google_maps_flutter/google_maps_flutter.dart' as _i18;

import 'ui/views/admin_home/admin_home_view.dart' as _i9;
import 'ui/views/admin_login/admin_login_view.dart' as _i10;
import 'ui/views/admin_qr/adminqr_view.dart' as _i12;
import 'ui/views/admin_qr_history/admin_qr_history_view.dart' as _i15;
import 'ui/views/admin_signup/admin_signup_view.dart' as _i11;
import 'ui/views/dashboard/dashboard_view.dart' as _i3;
import 'ui/views/google_map/google_map_view.dart' as _i14;
import 'ui/views/history/history_view.dart' as _i8;
import 'ui/views/login/login_view.dart' as _i2;
import 'ui/views/mange_user/manage_user_view.dart' as _i13;
import 'ui/views/otp/otp_view.dart' as _i5;
import 'ui/views/profile/profile_view.dart' as _i7;
import 'ui/views/root/root_view.dart' as _i1;
import 'ui/views/scanner/scanner_view.dart' as _i4;
import 'ui/views/welcome/welcome_view.dart' as _i6;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    RoorApp.name: (routeData) {
      final args =
          routeData.argsAs<RoorAppArgs>(orElse: () => const RoorAppArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.RoorApp(key: args.key),
      );
    },
    LoginView.name: (routeData) {
      final args =
          routeData.argsAs<LoginViewArgs>(orElse: () => const LoginViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoginView(key: args.key),
      );
    },
    DashboardView.name: (routeData) {
      final args = routeData.argsAs<DashboardViewArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.DashboardView(
          key: args.key,
          role: args.role,
        ),
      );
    },
    ScannerView.name: (routeData) {
      final args = routeData.argsAs<ScannerViewArgs>(
          orElse: () => const ScannerViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.ScannerView(key: args.key),
      );
    },
    OtpView.name: (routeData) {
      final args = routeData.argsAs<OtpViewArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.OtpView(
          key: args.key,
          verificationId: args.verificationId,
        ),
      );
    },
    WelcomeView.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.WelcomeView(),
      );
    },
    ProfileView.name: (routeData) {
      final args = routeData.argsAs<ProfileViewArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.ProfileView(
          key: args.key,
          isBottom: args.isBottom,
        ),
      );
    },
    HistoryView.name: (routeData) {
      final args = routeData.argsAs<HistoryViewArgs>(
          orElse: () => const HistoryViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.HistoryView(key: args.key),
      );
    },
    AdminHomeView.name: (routeData) {
      final args = routeData.argsAs<AdminHomeViewArgs>(
          orElse: () => const AdminHomeViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.AdminHomeView(key: args.key),
      );
    },
    AdminLoginScreenView.name: (routeData) {
      final args = routeData.argsAs<AdminLoginScreenViewArgs>(
          orElse: () => const AdminLoginScreenViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.AdminLoginScreenView(key: args.key),
      );
    },
    AdminSignUpView.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.AdminSignUpView(),
      );
    },
    AdminQrView.name: (routeData) {
      final args = routeData.argsAs<AdminQrViewArgs>(
          orElse: () => const AdminQrViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.AdminQrView(key: args.key),
      );
    },
    ManageUserView.name: (routeData) {
      final args = routeData.argsAs<ManageUserViewArgs>(
          orElse: () => const ManageUserViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.ManageUserView(key: args.key),
      );
    },
    GoogleMapView.name: (routeData) {
      final args = routeData.argsAs<GoogleMapViewArgs>();
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.GoogleMapView(
          key: args.key,
          location: args.location,
        ),
      );
    },
    AdminQrHistoryView.name: (routeData) {
      final args = routeData.argsAs<AdminQrHistoryViewArgs>(
          orElse: () => const AdminQrHistoryViewArgs());
      return _i16.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.AdminQrHistoryView(key: args.key),
      );
    },
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(
          RoorApp.name,
          path: '/',
        ),
        _i16.RouteConfig(
          LoginView.name,
          path: '/login-view',
        ),
        _i16.RouteConfig(
          DashboardView.name,
          path: '/dashboard-view',
        ),
        _i16.RouteConfig(
          ScannerView.name,
          path: '/scanner-view',
        ),
        _i16.RouteConfig(
          OtpView.name,
          path: '/otp-view',
        ),
        _i16.RouteConfig(
          WelcomeView.name,
          path: '/welcome-view',
        ),
        _i16.RouteConfig(
          ProfileView.name,
          path: '/profile-view',
        ),
        _i16.RouteConfig(
          HistoryView.name,
          path: '/history-view',
        ),
        _i16.RouteConfig(
          AdminHomeView.name,
          path: '/admin-home-view',
        ),
        _i16.RouteConfig(
          AdminLoginScreenView.name,
          path: '/admin-login-screen-view',
        ),
        _i16.RouteConfig(
          AdminSignUpView.name,
          path: '/admin-sign-up-view',
        ),
        _i16.RouteConfig(
          AdminQrView.name,
          path: '/admin-qr-view',
        ),
        _i16.RouteConfig(
          ManageUserView.name,
          path: '/manage-user-view',
        ),
        _i16.RouteConfig(
          GoogleMapView.name,
          path: '/google-map-view',
        ),
        _i16.RouteConfig(
          AdminQrHistoryView.name,
          path: '/admin-qr-history-view',
        ),
      ];
}

/// generated route for
/// [_i1.RoorApp]
class RoorApp extends _i16.PageRouteInfo<RoorAppArgs> {
  RoorApp({_i17.Key? key})
      : super(
          RoorApp.name,
          path: '/',
          args: RoorAppArgs(key: key),
        );

  static const String name = 'RoorApp';
}

class RoorAppArgs {
  const RoorAppArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'RoorAppArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.LoginView]
class LoginView extends _i16.PageRouteInfo<LoginViewArgs> {
  LoginView({_i17.Key? key})
      : super(
          LoginView.name,
          path: '/login-view',
          args: LoginViewArgs(key: key),
        );

  static const String name = 'LoginView';
}

class LoginViewArgs {
  const LoginViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'LoginViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.DashboardView]
class DashboardView extends _i16.PageRouteInfo<DashboardViewArgs> {
  DashboardView({
    _i17.Key? key,
    required String role,
  }) : super(
          DashboardView.name,
          path: '/dashboard-view',
          args: DashboardViewArgs(
            key: key,
            role: role,
          ),
        );

  static const String name = 'DashboardView';
}

class DashboardViewArgs {
  const DashboardViewArgs({
    this.key,
    required this.role,
  });

  final _i17.Key? key;

  final String role;

  @override
  String toString() {
    return 'DashboardViewArgs{key: $key, role: $role}';
  }
}

/// generated route for
/// [_i4.ScannerView]
class ScannerView extends _i16.PageRouteInfo<ScannerViewArgs> {
  ScannerView({_i17.Key? key})
      : super(
          ScannerView.name,
          path: '/scanner-view',
          args: ScannerViewArgs(key: key),
        );

  static const String name = 'ScannerView';
}

class ScannerViewArgs {
  const ScannerViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'ScannerViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.OtpView]
class OtpView extends _i16.PageRouteInfo<OtpViewArgs> {
  OtpView({
    _i17.Key? key,
    required String verificationId,
  }) : super(
          OtpView.name,
          path: '/otp-view',
          args: OtpViewArgs(
            key: key,
            verificationId: verificationId,
          ),
        );

  static const String name = 'OtpView';
}

class OtpViewArgs {
  const OtpViewArgs({
    this.key,
    required this.verificationId,
  });

  final _i17.Key? key;

  final String verificationId;

  @override
  String toString() {
    return 'OtpViewArgs{key: $key, verificationId: $verificationId}';
  }
}

/// generated route for
/// [_i6.WelcomeView]
class WelcomeView extends _i16.PageRouteInfo<void> {
  const WelcomeView()
      : super(
          WelcomeView.name,
          path: '/welcome-view',
        );

  static const String name = 'WelcomeView';
}

/// generated route for
/// [_i7.ProfileView]
class ProfileView extends _i16.PageRouteInfo<ProfileViewArgs> {
  ProfileView({
    _i17.Key? key,
    required bool isBottom,
  }) : super(
          ProfileView.name,
          path: '/profile-view',
          args: ProfileViewArgs(
            key: key,
            isBottom: isBottom,
          ),
        );

  static const String name = 'ProfileView';
}

class ProfileViewArgs {
  const ProfileViewArgs({
    this.key,
    required this.isBottom,
  });

  final _i17.Key? key;

  final bool isBottom;

  @override
  String toString() {
    return 'ProfileViewArgs{key: $key, isBottom: $isBottom}';
  }
}

/// generated route for
/// [_i8.HistoryView]
class HistoryView extends _i16.PageRouteInfo<HistoryViewArgs> {
  HistoryView({_i17.Key? key})
      : super(
          HistoryView.name,
          path: '/history-view',
          args: HistoryViewArgs(key: key),
        );

  static const String name = 'HistoryView';
}

class HistoryViewArgs {
  const HistoryViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'HistoryViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.AdminHomeView]
class AdminHomeView extends _i16.PageRouteInfo<AdminHomeViewArgs> {
  AdminHomeView({_i17.Key? key})
      : super(
          AdminHomeView.name,
          path: '/admin-home-view',
          args: AdminHomeViewArgs(key: key),
        );

  static const String name = 'AdminHomeView';
}

class AdminHomeViewArgs {
  const AdminHomeViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AdminHomeViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i10.AdminLoginScreenView]
class AdminLoginScreenView
    extends _i16.PageRouteInfo<AdminLoginScreenViewArgs> {
  AdminLoginScreenView({_i17.Key? key})
      : super(
          AdminLoginScreenView.name,
          path: '/admin-login-screen-view',
          args: AdminLoginScreenViewArgs(key: key),
        );

  static const String name = 'AdminLoginScreenView';
}

class AdminLoginScreenViewArgs {
  const AdminLoginScreenViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AdminLoginScreenViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i11.AdminSignUpView]
class AdminSignUpView extends _i16.PageRouteInfo<void> {
  const AdminSignUpView()
      : super(
          AdminSignUpView.name,
          path: '/admin-sign-up-view',
        );

  static const String name = 'AdminSignUpView';
}

/// generated route for
/// [_i12.AdminQrView]
class AdminQrView extends _i16.PageRouteInfo<AdminQrViewArgs> {
  AdminQrView({_i17.Key? key})
      : super(
          AdminQrView.name,
          path: '/admin-qr-view',
          args: AdminQrViewArgs(key: key),
        );

  static const String name = 'AdminQrView';
}

class AdminQrViewArgs {
  const AdminQrViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AdminQrViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.ManageUserView]
class ManageUserView extends _i16.PageRouteInfo<ManageUserViewArgs> {
  ManageUserView({_i17.Key? key})
      : super(
          ManageUserView.name,
          path: '/manage-user-view',
          args: ManageUserViewArgs(key: key),
        );

  static const String name = 'ManageUserView';
}

class ManageUserViewArgs {
  const ManageUserViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'ManageUserViewArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.GoogleMapView]
class GoogleMapView extends _i16.PageRouteInfo<GoogleMapViewArgs> {
  GoogleMapView({
    _i17.Key? key,
    required _i18.LatLng location,
  }) : super(
          GoogleMapView.name,
          path: '/google-map-view',
          args: GoogleMapViewArgs(
            key: key,
            location: location,
          ),
        );

  static const String name = 'GoogleMapView';
}

class GoogleMapViewArgs {
  const GoogleMapViewArgs({
    this.key,
    required this.location,
  });

  final _i17.Key? key;

  final _i18.LatLng location;

  @override
  String toString() {
    return 'GoogleMapViewArgs{key: $key, location: $location}';
  }
}

/// generated route for
/// [_i15.AdminQrHistoryView]
class AdminQrHistoryView extends _i16.PageRouteInfo<AdminQrHistoryViewArgs> {
  AdminQrHistoryView({_i17.Key? key})
      : super(
          AdminQrHistoryView.name,
          path: '/admin-qr-history-view',
          args: AdminQrHistoryViewArgs(key: key),
        );

  static const String name = 'AdminQrHistoryView';
}

class AdminQrHistoryViewArgs {
  const AdminQrHistoryViewArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'AdminQrHistoryViewArgs{key: $key}';
  }
}
