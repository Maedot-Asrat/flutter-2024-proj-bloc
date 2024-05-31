// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zemnanit/Buissness_logic/booking_bloc/booking_bloc.dart';
// import 'package:zemnanit/Buissness_logic/booking_bloc/booking_state.dart';
// import 'package:zemnanit/presentation/screens/common_widgets/appbar.dart';

// class MyAppointments extends StatefulWidget {
//   @override
//   State<MyAppointments> createState() => _MyAppointmentsState();
// }

// class _MyAppointmentsState extends State<MyAppointments> {
//   final BookingBloc bookingBloc = BookingBloc();

//   @override
//   void initState() {
//     bookingBloc.add(BookingInitialFetchEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MyAppBar(),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20.0),
//           child: Column(
//             children: [
//               Text(
//                 'My Appointments',
//                 style: TextStyle(
//                   color: Colors.red[400],
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               Expanded(
//                 child: BlocBuilder<BookingBloc, BookingState>(
//                   builder: (context, state) {
//                     if (state is BookingLoaded) {
//                       final bookings = state.bookings;

//                       return ListView.builder(
//                         itemCount: bookings.length,
//                         itemBuilder: (context, index) {
//                           final booking = bookings[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(10.0),
//                               child: Container(
//                                 padding: EdgeInsets.all(20),
//                                 color: Colors.deepOrange[100],
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 140,
//                                       width: 100,
//                                       child: Image.asset(
//                                         booking.image,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                     SizedBox(width: 20),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           booking.salonName,
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Icon(Icons.location_on,
//                                                 color: Colors.red[400]),
//                                             Text(
//                                               booking.location,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           booking.salonName,
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         Text(booking.time),
//                                         Text(booking.comments),
//                                         SizedBox(height: 20),
//                                         Row(
//                                           children: [
//                                             ElevatedButton(
//                                               onPressed: () {
                                               
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 foregroundColor:
//                                                     Colors.red[400],
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               child: Text('Edit'),
//                                             ),
//                                             SizedBox(width: 10.0),
//                                             ElevatedButton(
//                                               onPressed: () {
                                                
//                                               },
//                                               style: ElevatedButton.styleFrom(
//                                                 foregroundColor:
//                                                     Colors.red[400],
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               child: Text('Delete'),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     } else {
//                       return Center(child: Text('No appointments yet'));
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
