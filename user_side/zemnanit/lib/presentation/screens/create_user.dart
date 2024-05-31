// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Buissness_logic/auth/auth_bloc.dart';
import 'package:zemnanit/Buissness_logic/auth/auth_event.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';
import 'package:zemnanit/presentation/screens/login_user.dart';

void main() {
  runApp(MaterialApp(
    // debugShowCheckedModeBanner: true,
    home: BlocProvider(
      create: (context) => AuthBloc(),
      child: User(),
    ),
  ));
}

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool _obscurePassword = true;
  bool _obscureconfirm = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1CFC3),
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
            child: Column(children: <Widget>[
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Full Name:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: fullnameController,
              decoration: InputDecoration(
                labelText: "Enter your Full Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Age:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: "Enter your age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Password:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Enter your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Confirm Password:",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(55.0, 10.0, 55.0, 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: TextField(
              controller: passwordController,
              obscureText: _obscureconfirm,
              decoration: InputDecoration(
                labelText: "Confirm your password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(_obscureconfirm
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscureconfirm = !_obscureconfirm;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200,
                        50), // Adjust the width and height values as needed
                  ),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        color: Color.fromARGB(255, 176, 55, 11),
                        fontSize: 18.0),
                  ),
                  onPressed: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        fullnameController.text.isNotEmpty &&
                        ageController.text.isNotEmpty) {
                      context.read<AuthBloc>().add(
                            SignupRequested(
                              email: emailController.text,
                              password: passwordController.text,
                              fullname: fullnameController.text,
                              age: ageController.text,
                            ),
                          );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Log_in(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please fill in all the required fields.',
                          ),
                        ),
                      );
                    }
                  })),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    200, 50), // Adjust the width and height values as needed
              ),
              child: Text(
                "Already have an account? Login",
                style: TextStyle(
                    color: Color.fromARGB(255, 176, 55, 11), fontSize: 18.0),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Log_in(),
                  ),
                );
              },
            ),
          ),
        ])),
      ),
    );
  }
}
