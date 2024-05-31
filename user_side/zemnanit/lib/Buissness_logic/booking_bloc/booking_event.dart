part of 'booking_bloc.dart';

abstract class BookingEvent {}

class BookingInitialFetchEvent extends BookingEvent {}

class BookingAddEvent extends BookingEvent {
  final BookingModel booking;
  BookingAddEvent(this.booking);
}

class BookingDeleteEvent extends BookingEvent {
  final BookingModel booking;
  BookingDeleteEvent(this.booking);
}

class Logout extends BookingEvent {}

class DeleteAppointment extends BookingEvent {
  final String id;

  DeleteAppointment(this.id);
}

class BookingDeleted extends BookingState {}

class BookingError extends BookingState {
  final String errorMessage;

  BookingError(this.errorMessage);
}
