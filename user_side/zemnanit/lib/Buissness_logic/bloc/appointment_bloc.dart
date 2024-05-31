import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Buissness_logic/bloc/appointment_event.dart';
import 'package:zemnanit/Buissness_logic/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final http.Client _httpClient;
  final String _baseUrl;

  AppointmentBloc(this._httpClient, this._baseUrl)
      : super(AppointmentState.initial()) {
    on<GetAppointments>(_getAppointments);
    on<DeleteAppointment>(_deleteAppointment);
    on<Logout>(_logout);
  }
  Future<void> _getAppointments(
      GetAppointments event, Emitter<AppointmentState> emit) async {
    try {
      final response = await _httpClient.get(
        Uri.parse('$_baseUrl/appointments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final appointments = jsonDecode(response.body) as List<dynamic>;
        emit(AppointmentState.success(appointments));
      } else {
        emit(AppointmentState.failure(
            'Failed to fetch appointments. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AppointmentState.failure(e.toString()));
    }
  }

  Future<void> _deleteAppointment(
      DeleteAppointment event, Emitter<AppointmentState> emit) async {
    try {
      final response = await _httpClient.delete(
        Uri.parse('$_baseUrl/appointments/${event.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(AppointmentState.success('Appointment deleted successfully'));
      } else {
        emit(AppointmentState.failure(
            'Failed to delete appointment. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AppointmentState.failure(e.toString()));
    }
  }

  void _logout(Logout event, Emitter<AppointmentState> emit) {
    emit(AppointmentState.initial());
  }
}
