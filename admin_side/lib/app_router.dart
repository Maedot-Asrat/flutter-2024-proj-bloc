import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'manage_bloc.dart';
import 'salon_list_screen.dart';

class AppRouter {
  final String accessToken;

  AppRouter({required this.accessToken});

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => ManageUsersPage(accessToken: accessToken),
      ),
      GoRoute(
        path: '/salons',
        builder: (context, state) => SalonListScreen(accessToken: accessToken),
      ),
    ],
  );
}
