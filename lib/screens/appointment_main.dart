import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/appointments.dart';

class AppointmentMain extends StatefulWidget {
  static const id = 'appointment_main';
  final Appointment appointment;

  AppointmentMain({this.appointment});

  @override
  _AppointmentMainState createState() => _AppointmentMainState();
}

class _AppointmentMainState extends State<AppointmentMain> {
  String gif = 'images/practice_GIF.gif';
  Appointment appointment;

  void initState() {
    appointment = widget.appointment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cita de ${appointment.type.toLowerCase()}'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: GifAndButtons(gif, () => {}, Icon(Icons.arrow_back),
                  () => {}, Icon(Icons.check), () => {}),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Fecha: ${DateFormat.yMd().format(appointment.date)}\nHora: ${(appointment.time).format(context)}\nTipo: ${appointment.type}\nLugar: ${appointment.place}\nInformación adicional: ${appointment.additionalInformation}',
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          child: Text('Motivo de consulta'),
                          onPressed: () => {},
                        ),
                        ElevatedButton(
                          child: Text('Información complementaria'),
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
