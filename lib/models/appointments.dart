import 'package:flutter/material.dart';

class Appointment {
  final int id;
  final String place;
  final String type;
  final String additionalInformation;
  final DateTime date;
  final TimeOfDay time;

  Appointment({
    @required this.id,
    @required this.place,
    @required this.type,
    @required this.additionalInformation,
    @required this.date,
    @required this.time,
  });
}
