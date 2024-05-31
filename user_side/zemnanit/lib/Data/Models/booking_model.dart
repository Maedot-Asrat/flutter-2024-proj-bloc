import 'dart:convert';

class BookingModel {
  final String hairstyle;
  final String comment;
  final String date;
  final String time;

  BookingModel({
    required this.comment,
    required this.hairstyle,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'hairstyle': hairstyle,
      'date': date,
      'time': time,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      comment: map['comment'] ?? '',
      hairstyle: map['hairstyle'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));
}
