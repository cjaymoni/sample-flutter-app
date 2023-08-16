import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_screens/asset_screens/asset_form_screen.dart';
import 'app_screens/asset_screens/assets_list_screen.dart';
import 'app_screens/auth_screens/forgot_password_screen.dart';
import 'app_screens/auth_screens/login_screen.dart';
import 'app_screens/auth_screens/register_screen.dart';
import 'package:provider/provider.dart';

import 'app_screens/dashboard_screen.dart';
import 'app_screens/report_screens/reports_home.dart';

void main() {
  final goRouter = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
          routes: const <GoRoute>[],
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen()),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/register',
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterScreen()),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/forgot-password',
          builder: (BuildContext context, GoRouterState state) =>
              const ForgotPasswordScreen()),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) =>
              DashboardScreen()),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/asset-list',
          builder: (BuildContext context, GoRouterState state) =>
              const AssetsList()),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/add-asset',
          builder: (BuildContext context, GoRouterState state) =>
              const AssetForm(
                isEditForm: false,
              )),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/edit-asset',
          builder: (BuildContext context, GoRouterState state) =>
              const AssetForm(
                isEditForm: true,
              )),
      GoRoute(
          routes: const <GoRoute>[],
          path: '/reports',
          builder: (BuildContext context, GoRouterState state) =>
              const ReportsHome()),
    ],
  );

  runApp(ChangeNotifierProvider(
    create: (context) => AuthModel(),
    child: MyApp(goRouter: goRouter),
  ));
}

class AuthModel extends ChangeNotifier {
  bool _loggedIn = false;

  bool get loggedIn => _loggedIn;

  void login() {
    _loggedIn = true;
    notifyListeners();
  }

  void logout() {
    _loggedIn = false;
    notifyListeners();
  }
}

final AuthModel authModel = AuthModel();

class AuthChecker extends StatelessWidget {
  final Widget child;

  const AuthChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: authModel,
      builder: (context, child) {
        return authModel.loggedIn ? child! : const LoginScreen();
      },
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;
  const MyApp({super.key, required this.goRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: goRouter.routerDelegate,
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        title: 'Flutter App with Auth');
  }
}
