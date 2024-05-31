import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Buissness_logic/auth/auth_event.dart';
import 'package:zemnanit/Buissness_logic/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final String baseUrl = 'http://127.0.0.1:3000';

  AuthBloc() : super(AuthInitial()) {
    on<SignupRequested>(_onSignupRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onSignupRequested(
      SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(loading: true));
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
          'password': event.password,
          'fullname': event.fullname,
          'age': event.age,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(AuthSuccess(message: "User created successfully"));
      } else {
        emit(AuthFailure(
            error:
                'Failed to create user. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    // Set loading state
    emit(AuthLoading(loading: true));

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': event.email,
          'password': event.password,
        }),
      );

      // Log response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final access_token = responseBody['access_token'];
        emit(AuthLoginSuccess(
          message: "Logged in successfully",
          email: event.email,
          access_token: access_token,
        ));
      } else if (response.statusCode == 401) {
        emit(AuthFailure(error: 'Invalid email or password'));
      } else {
        final responseBody = json.decode(utf8.decode(response.bodyBytes));
        final errorMessage = responseBody['error'] ?? 'Failed to login';
        emit(AuthFailure(
          error:
              'Failed to login. Status code: ${response.statusCode}. Error: $errorMessage',
        ));
      }
    } catch (e) {
      print('Login error: $e');
      emit(AuthFailure(error: e.toString()));
    } finally {
      emit(AuthLoading(loading: false));
    }
  }
}
