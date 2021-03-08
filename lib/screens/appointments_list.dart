// import 'package:atenciones/main.dart';
// import 'package:atenciones/screens/show_images.dart';

import 'package:flutter/material.dart';
import '../models/appointments.dart';
import 'package:intl/intl.dart';

class AppointmentsList extends StatefulWidget {
  final List<Appointment> appointments;
  final Function deleteInformation;
  final Function urlGIF;

  AppointmentsList(this.appointments, this.deleteInformation, this.urlGIF);

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  List<Appointment> _appointments;
  Function deleteInformation;

  // _AppointmentsListState(this._appointments, this.deleteInformation);

  _iconForType(String type) {
    if (type.toUpperCase() == "MEDICINA GENERAL") {
      return 'images/general_medicine.jpg';
    } else if (type.toUpperCase() == "ODONTOLOGÍA") {
      return 'images/odontology.jpg';
    } else {
      return 'images/no_appointments.png';
    }
  }

  @override
  void initState() {
    _appointments = widget.appointments;
    deleteInformation = widget.deleteInformation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 395,
      child: _appointments.isEmpty
          ? NoAppointmentsYet()
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () => widget.urlGIF(_appointments[index].type),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: ListTile(
                        minVerticalPadding: 10,
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(
                              _iconForType(_appointments[index].type)
                                  .toString()),
                        ),
                        title: Text(
                          DateFormat.yMd().format(_appointments[index].date),
                        ),
                        subtitle: Text(
                          '${_appointments[index].type} - ${_appointments[index].place}\nHora: ${(_appointments[index].time).format(context)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteInformation(_appointments[index].id),
                        )),
                  ),
                );
              },
              itemCount: _appointments.length,
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

class ShowGIF extends StatefulWidget {
  final String gif;

  ShowGIF(this.gif);

  @override
  _ShowGIFState createState() => _ShowGIFState();
}

class _ShowGIFState extends State<ShowGIF> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.asset(widget.gif, width: 290),
      // child: Image.asset('images/practice2_GIF.gif', width: 290),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
