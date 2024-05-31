import 'package:flutter/material.dart';
import 'package:zemnanit/Buissness_logic/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Buissness_logic/nav_bloc/navigation_bloc.dart';
import 'package:zemnanit/presentation/Routes/generated_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<BookingBloc>(
          create: (context) => BookingBloc(),
        ),
      ],
      child: MyAppp(),
    ),
  );
}

class MyAppp extends StatelessWidget {
  const MyAppp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter BNB using BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
