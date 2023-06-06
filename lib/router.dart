import 'package:auto_route/auto_route.dart';
import 'package:qrapp/ui/views/admin_home/admin_home_view.dart';
import 'package:qrapp/ui/views/admin_login/admin_login_view.dart';
import 'package:qrapp/ui/views/admin_qr_history/admin_qr_history_view.dart';
import 'package:qrapp/ui/views/admin_signup/admin_signup_view.dart';
import 'package:qrapp/ui/views/admin_qr/adminqr_view.dart';
import 'package:qrapp/ui/views/google_map/google_map_view.dart';
import 'package:qrapp/ui/views/history/history_view.dart';
import 'package:qrapp/ui/views/mange_user/manage_user_view.dart';
import 'package:qrapp/ui/views/otp/otp_view.dart';
import 'package:qrapp/ui/views/profile/profile_view.dart';
import 'package:qrapp/ui/views/root/root_view.dart';
import 'package:qrapp/ui/views/scanner/scanner_view.dart';
import 'package:qrapp/ui/views/welcome/welcome_view.dart';

import 'ui/views/dashboard/dashboard_view.dart';
import 'ui/views/login/login_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: RoorApp, initial: true),
    AutoRoute(page: LoginView),
    AutoRoute(page: DashboardView),
    AutoRoute(page: ScannerView),
    AutoRoute(page: OtpView),
    AutoRoute(page: WelcomeView),
    AutoRoute(page: ProfileView),
    AutoRoute(page: HistoryView),
    AutoRoute(page: AdminHomeView),
    AutoRoute(page: AdminLoginScreenView),
    AutoRoute(page: AdminSignUpView),
    AutoRoute(page: AdminQrView),
    AutoRoute(page: ManageUserView),
    AutoRoute(page: GoogleMapView),
    AutoRoute(page: AdminQrHistoryView),
  ],
)
class $AppRouter {}
