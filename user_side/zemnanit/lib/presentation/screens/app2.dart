// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zemnanit/Buissness_logic/booking_bloc/booking_bloc.dart';
import 'package:zemnanit/Buissness_logic/booking_bloc/booking_state.dart';
import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppoinmentsPageState();
}

class _AppoinmentsPageState extends State<AppointmentsPage> {
  final BookingBloc postsBloc = BookingBloc();

  @override
  void initState() {
    postsBloc.add(BookingInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: BlocConsumer<BookingBloc, BookingState>(
          bloc: postsBloc,
          listenWhen: (previous, current) => current is BookingActionState,
          buildWhen: (previous, current) => current is! BookingActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case BookingSuccessful:
                final successState = state as BookingSuccessful;

                return Column(
                  children: [
                    Text(
                      'My Appointments',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: successState.bookings.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              color: Colors.deepOrange[200],
                              margin: const EdgeInsets.all(16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.cut),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            successState
                                                .bookings[index].hairStyle
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.lock_clock),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            successState.bookings[index].time
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(successState.bookings[index].date,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Edit Appointment')),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Delete Appointment')),
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
