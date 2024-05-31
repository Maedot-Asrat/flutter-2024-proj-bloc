// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Buissness_logic/auth/auth_bloc.dart';
import 'package:zemnanit/Buissness_logic/auth/auth_event.dart';
import 'package:zemnanit/presentation/screens/app2.dart';
import 'package:zemnanit/presentation/screens/main.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        home: Log_in(),
      ),
    ),
  );
}

class Log_in extends StatefulWidget {
  const Log_in({Key? key}) : super(key: key);

  @override
  State<Log_in> createState() => _LoginState();
}

class _LoginState extends State<Log_in> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zemnanit Beauty Salons',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400]),
            ),
            SizedBox(height: 10),
            Text('Welcome User!',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Enter Email',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.person, color: Colors.grey[600])),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter both email and password'),
                    ),
                  );
                } else {
                  context.read<AuthBloc>().add(
                        LoginRequested(
                            email: emailController.text,
                            password: passwordController.text),
                      );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAppp(),
                    ),
                  );
                }
              },
              child: Text('Login'),
            ),
            // if (authState.error != null) ...[
            //   SizedBox(height: 20),
            //   Text(authState.error!, style: TextStyle(color: Colors.red)),
            // ],
          ],
        ),
      ),
    );
  }
}
