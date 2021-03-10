// import 'package:atenciones/main.dart';
// import 'package:atenciones/screens/show_images.dart';

import 'package:flutter/material.dart';
import '../models/appointments.dart';
import 'package:intl/intl.dart';

class AppointmentsList extends StatefulWidget {
  final List<Appointment> pastAppointments;
  final List<Appointment> presentAppointments;
  final Function deleteAppointment;
  final Function gifForType;

  AppointmentsList(this.pastAppointments, this.presentAppointments,
      this.deleteAppointment, this.gifForType);

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  _iconForType(String type) {
    if (type == 'Medicina general') {
      return 'images/general_medicine.jpg';
    } else if (type == 'Odontología') {
      return 'images/odontology.jpg';
    } else {
      return 'images/no_appointments.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 395,
      child: widget.pastAppointments.isEmpty
          ? NoAppointmentsYet()
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return AppointmentCard(index, widget.pastAppointments,
                    widget.gifForType, widget.deleteAppointment, _iconForType);
              },
              itemCount: widget.pastAppointments.length,
            ),
    );
  }
}

class NoAppointmentsYet extends StatelessWidget {
  const NoAppointmentsYet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          "¡Aún no tienes citas!",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Container(
          height: 150,
          child: Image.asset(
            "images/no_appointments.png",
            fit: BoxFit.scaleDown,
          ),
        ),
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final int index;
  final List<Appointment> appointments;
  final Function gifForType;
  final Function iconForType;
  final Function deleteAppointment;

  AppointmentCard(this.index, this.appointments, this.gifForType,
      this.deleteAppointment, this.iconForType);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gifForType(appointments[index].type),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 3,
        ),
        child: ListTile(
            minVerticalPadding: 10,
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              backgroundImage:
                  AssetImage(iconForType(appointments[index].type).toString()),
            ),
            title: Text(
              DateFormat.yMd().format(appointments[index].date),
            ),
            subtitle: Text(
              '${appointments[index].type} - ${appointments[index].place}\nHora: ${(appointments[index].time).format(context)}',
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteAppointment(appointments[index].id),
            )),
      ),
    );
  }
}
