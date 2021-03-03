// import 'package:flutter/material.dart';

class ShowTypeImage {
  final String type;
  String _image = '';

  ShowTypeImage(this.type);

  initState() {
    if (type.toUpperCase() == 'MEDICINA GENERAL') {
      _image = 'images/general_medicine.jpg';
    } else if (type.toUpperCase() == "ODONTOLOGÍA") {
      _image = 'images/odontology.jpg';
    } else {
      _image = 'images/no_appointments.png';
    }

    return _image;
  }
}
