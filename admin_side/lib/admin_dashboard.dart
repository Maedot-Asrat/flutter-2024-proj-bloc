import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin_side/manage_bloc.dart';
import 'package:admin_side/addbloc.dart';
import 'package:admin_side/salon_list_screen.dart';

class AdminDashboard extends StatelessWidget {
  final String accessToken;

  AdminDashboard({required this.accessToken, required http.Client httpClient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ManageUsersPage(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Manage Users'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddSalonScreen(accessToken: accessToken),
                  ),
                );
              },
              child: Text('Add Salon'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SalonListScreen(accessToken: accessToken),
                  ),
                );
              },
              child: Text('View Salons'),
            ),
          ],
        ),
      ),
    );
  }
}
