class AppointmentEvent {}

class DeleteAppointment extends AppointmentEvent {
  final String id;

  DeleteAppointment(this.id);
}

class Logout extends AppointmentEvent {}

class GetAppointments extends AppointmentEvent {}
