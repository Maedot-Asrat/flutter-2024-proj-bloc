import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUsersPage extends StatefulWidget {
  final String accessToken;

  ManageUsersPage({required this.accessToken});

  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  bool _isLoading = false;
  List _users = [];
  Map<int, String> _selectedRoles = {};

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'http://localhost:3000/users'; // Replace with your backend URL
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer ${widget.accessToken}'},
      );

      if (response.statusCode == 200) {
        setState(() {
          _users = json.decode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load users')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserRole(String email, String newRole) async {
    final url =
        'http://localhost:3000/users/update-role'; // Adjust URL to your API endpoint

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({'email': email, 'role': newRole}),
      );

      switch (response.statusCode) {
        case 200:
          setState(() {
            final index = _users.indexWhere((user) => user['email'] == email);
            if (index != -1) {
              _users[index]['role'] = newRole;
              _selectedRoles[index] = newRole;
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Role updated for $email to $newRole')),
          );
          break;
        case 400:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bad request: Invalid data provided')),
          );
          break;
        case 401:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unauthorized: Invalid access token')),
          );
          break;
        case 403:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Forbidden: You do not have permission to update this user')),
          );
          break;
        case 404:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not found')),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update user role')),
          );
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _deleteUser(String email) async {
    final url =
        'http://localhost:3000/users/$email'; // Adjust URL to your API endpoint

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _users.removeWhere((user) => user['email'] == email);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete user')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                var user = _users[index];
                final selectedRole = _selectedRoles[index] ?? user['role'];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(user['email']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Role: $selectedRole'),
                              SizedBox(height: 10),
                              DropdownButton<String>(
                                value: selectedRole,
                                onChanged: (newRole) {
                                  if (newRole != null &&
                                      newRole != selectedRole) {
                                    setState(() {
                                      _selectedRoles[index] = newRole;
                                    });
                                    _updateUserRole(user['email'], newRole);
                                  }
                                },
                                items: [
                                  'admin',
                                  'user'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              onPressed: () {
                                _deleteUser(user['email']);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
