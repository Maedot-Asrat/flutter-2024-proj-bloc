import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_admin.dart';
import 'manage_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final http.Client httpClient = http.Client();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AdminLoginPage(),
        '/admin_dashboard': (context) => AdminDash(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/manage_bloc') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return ManageUsersPage(
                accessToken: args['accessToken'],
                httpClient: httpClient,
              );
            },
          );
        }
        return null;
      },
    );
  }
}

class AdminDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // You should pass the access token here when navigating
            Navigator.pushNamed(context, '/manage_bloc', arguments: {
              'accessToken':
                  'your_access_token_here', // replace with the actual token
            });
          },
          child: Text('Manage Users'),
        ),
      ),
    );
  }
}

class ManageUsersPage extends StatefulWidget {
  final String accessToken;
  final http.Client httpClient;

  const ManageUsersPage({
    required this.accessToken,
    required this.httpClient,
  });

  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  bool _isLoading = true;
  String _errorMessage = '';
  List<dynamic> _users = [];
  Map<int, String> _selectedRoles = {};

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final Uri uri = Uri.parse('http://[::1]:3000/users');

    try {
      final http.Response response = await widget.httpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _users = jsonDecode(response.body);
          _isLoading = false;
        });
      } else if (response.statusCode == 204) {
        setState(() {
          _users = [];
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _errorMessage = 'Unauthorized access. Please log in again.';
          _isLoading = false;
        });
      } else if (response.statusCode == 403) {
        setState(() {
          _errorMessage =
              'Forbidden. You do not have permission to view this data.';
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = 'Users not found.';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load users';
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching users: $error');
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(String email, String newRole) async {
    final Uri uri = Uri.parse('http://[::1]:3000/users/update-role');

    try {
      final http.Response response = await widget.httpClient.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.accessToken}',
        },
        body: jsonEncode({'email': email, 'role': newRole}),
      );

      if (response.statusCode == 200) {
        setState(() {
          final index = _users.indexWhere((user) => user['email'] == email);
          if (index != -1) {
            _users[index]['role'] = newRole;
            _selectedRoles[index] = newRole;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Role updated for $email to $newRole'),
        ));
      } else if (response.statusCode == 204) {
        setState(() {
          final index = _users.indexWhere((user) => user['email'] == email);
          if (index != -1) {
            _users[index]['role'] = newRole;
            _selectedRoles[index] = newRole;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Role updated for $email to $newRole'),
        ));
      } else if (response.statusCode == 204) {
        setState(() {
          final index = _users.indexWhere((user) => user['email'] == email);
          if (index != -1) {
            _users[index]['role'] = newRole;
            _selectedRoles[index] = newRole;
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Role updated for $email to $newRole'),
        ));
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Unauthorized access. Please log in again.'),
        ));
      } else if (response.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Forbidden. You do not have permission to update roles.'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update role for $email'),
        ));
      }
    } catch (error) {
      print('Error updating user role: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    final user = _users[index];
                    final selectedRole = _selectedRoles[index] ?? user['role'];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(user['email']),
                        subtitle: Text('Role: $selectedRole'),
                        trailing: DropdownButton<String>(
                          value: selectedRole,
                          onChanged: (newRole) {
                            if (newRole != null) {
                              setState(() {
                                _selectedRoles[index] = newRole;
                              });
                              _updateUserRole(user['email'], newRole);
                            }
                          },
                          items: ['admin', 'user']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
