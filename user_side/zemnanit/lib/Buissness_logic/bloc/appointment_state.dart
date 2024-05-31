class AppointmentState {
  final List<dynamic>? appointments;
  final String? message;
  final String? error;

  AppointmentState._({this.appointments, this.message, this.error});

  factory AppointmentState.initial() {
    return AppointmentState._(message: null, error: null);
  }

  factory AppointmentState.success(dynamic data) {
    if (data is List<dynamic>) {
      return AppointmentState._(appointments: data, message: null, error: null);
    } else {
      return AppointmentState._(
          appointments: null, message: data.toString(), error: null);
    }
  }

  factory AppointmentState.failure(String error) {
    return AppointmentState._(appointments: null, message: null, error: error);
  }
}
