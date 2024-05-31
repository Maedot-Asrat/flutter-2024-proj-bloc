import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zemnanit/Buissness_logic/booking_bloc/booking_state.dart';
import 'package:http/http.dart' as http;
import 'package:zemnanit/Data/Models/booking_model.dart';
import 'package:zemnanit/Data/Repositories/books_repo.dart';

part 'booking_event.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<BookingInitialFetchEvent>(bookingInitialFetchEvent);
    on<BookingAddEvent>(bookingsAddEvent);
  }

  FutureOr<void> bookingInitialFetchEvent(
      BookingInitialFetchEvent event, Emitter<BookingState> emit) async {
    List<BookingModel> bookings = await BookingRepo.fetchAppointments();
    emit(BookingSuccessful(bookings: bookings));
    //
    //
  }

  FutureOr<void> bookingsAddEvent(
      BookingAddEvent event, Emitter<BookingState> emit) async {
    bool success = await BookingRepo.addAppointment(
      hairStyle: event.booking.hairstyle,
      date: event.booking.date,
      time: event.booking.time,
      comment: event.booking.comment,
      // user: event.booking.user,
    );

    if (success) {
      emit(BookingAdditionSuccessState());
    } else {
      emit(BookingAdditionErrorState(
          'Failed to add appointment. Please try again.'));
    }
  }
}
