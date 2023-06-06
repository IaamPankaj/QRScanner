// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:qrapp/ui/views/admin_home/admin_home_view_model.dart' as _i3;
import 'package:qrapp/ui/views/admin_login/admin_login_viewmodel.dart' as _i4;
import 'package:qrapp/ui/views/admin_qr/adminqr_view_model.dart' as _i6;
import 'package:qrapp/ui/views/admin_qr_history/admin_qr_history_view_model.dart'
    as _i5;
import 'package:qrapp/ui/views/admin_signup/admin_signup_viewmodel.dart' as _i7;
import 'package:qrapp/ui/views/dashboard/dashboard_view_model.dart' as _i8;
import 'package:qrapp/ui/views/google_map/google_map_view_model.dart' as _i9;
import 'package:qrapp/ui/views/history/history_view_model.dart' as _i10;
import 'package:qrapp/ui/views/login/login_view_model.dart' as _i11;
import 'package:qrapp/ui/views/mange_user/manage_user_view_model.dart' as _i12;
import 'package:qrapp/ui/views/otp/otp_view_model.dart' as _i13;
import 'package:qrapp/ui/views/profile/profile_view_model.dart' as _i14;
import 'package:qrapp/ui/views/root/root_view_model.dart' as _i15;
import 'package:qrapp/ui/views/scanner/scanner_view_model.dart' as _i16;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AdminHomeViewModel>(() => _i3.AdminHomeViewModel());
  gh.lazySingleton<_i4.AdminLoginScreenViewModel>(
      () => _i4.AdminLoginScreenViewModel());
  gh.lazySingleton<_i5.AdminQrHistoryViewModel>(
      () => _i5.AdminQrHistoryViewModel());
  gh.lazySingleton<_i6.AdminQrViewModel>(() => _i6.AdminQrViewModel());
  gh.lazySingleton<_i7.AdminSignUpViewModel>(() => _i7.AdminSignUpViewModel());
  gh.lazySingleton<_i8.DashboardViewModel>(() => _i8.DashboardViewModel());
  gh.lazySingleton<_i9.GoogleMapViewModel>(() => _i9.GoogleMapViewModel());
  gh.lazySingleton<_i10.HistroyViewModel>(() => _i10.HistroyViewModel());
  gh.lazySingleton<_i11.LoginViewModel>(() => _i11.LoginViewModel());
  gh.lazySingleton<_i12.ManageUserViewModel>(() => _i12.ManageUserViewModel());
  gh.lazySingleton<_i13.OtpViewModel>(() => _i13.OtpViewModel());
  gh.lazySingleton<_i14.ProfileViewModel>(() => _i14.ProfileViewModel());
  gh.lazySingleton<_i15.RootViewModel>(() => _i15.RootViewModel());
  gh.lazySingleton<_i16.ScannerViewModel>(() => _i16.ScannerViewModel());
  return getIt;
}
