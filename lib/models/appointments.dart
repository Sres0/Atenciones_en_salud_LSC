import 'package:flutter/material.dart';

class Appointment {
  final int id;
  final String place;
  final String type;
  final DateTime date;
  final TimeOfDay time;

  Appointment({
    @required this.id,
    @required this.date,
    @required this.time,
    @required this.type,
    @required this.place,
  });
}
