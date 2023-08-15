import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_report_app/app_screens/asset_screens/asset_form_screen.dart';
import 'package:sample_report_app/app_screens/asset_screens/assets_list_screen.dart';
import 'package:sample_report_app/app_screens/auth_screens/forgot_password_screen.dart';
import 'package:sample_report_app/app_screens/auth_screens/login_screen.dart';
import 'package:sample_report_app/app_screens/auth_screens/register_screen.dart';
import 'package:sample_report_app/app_screens/dashboard_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        // Use the LoginScreen widget
      );

  // {
  //   return const MaterialApp.router(
  //     routerDelegate: _router,
  //     debugShowCheckedModeBanner: false,
  //     title: 'My App',
  //     home: LoginScreen(),
  //     // Use the LoginScreen widget
  //   );
  // }

  final GoRouter _router = GoRouter(
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
          path: '/assets',
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
    ],
  );
}
