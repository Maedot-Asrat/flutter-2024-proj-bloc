import 'package:flutter/material.dart';

import 'package:zemnanit/presentation/screens/app2.dart';

void main() async {
  runApp(new MyApppp());
}

class MyApppp extends StatelessWidget {
  const MyApppp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentsPage(),
    );
  }
}
