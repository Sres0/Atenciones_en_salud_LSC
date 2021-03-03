// import 'package:atenciones/main.dart';
// import 'package:atenciones/screens/show_images.dart';

import 'package:flutter/material.dart';
import '../models/appointments.dart';
import 'package:intl/intl.dart';

class AppointmentsList extends StatefulWidget {
  final List<Appointment> appointments;
  final Function editInformation;
  final Function urlGIF;

  AppointmentsList(this.appointments, this.editInformation, this.urlGIF);

  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  List<Appointment> _appointments;
  Function editInformation;

  // _AppointmentsListState(this._appointments, this.editInformation);

  _iconForType(String type) {
    if (type.toUpperCase() == "MEDICINA GENERAL") {
      return 'images/general_medicine.jpg';
    } else if (type.toUpperCase() == "ODONTOLOGÍA") {
      return 'images/odontology.jpg';
    } else {
      return 'images/no_appointments.png';
    }

    // return _image;
  }

  @override
  void initState() {
    _appointments = widget.appointments;
    editInformation = widget.editInformation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColorLight),
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      height: 395,
      child: _appointments.isEmpty
          ? NoAppointmentsYet()
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  // onTap: () => print(_appointments[index].id),
                  onTap: () => widget.urlGIF(_appointments[index].type),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 3,
                    ),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(
                              _iconForType(_appointments[index].type)
                                  .toString()),
                        ),
                        title: Text(
                          DateFormat.yMd().format(_appointments[index].date),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          "${_appointments[index].type} - ${_appointments[index].place}\nHora: ${(_appointments[index].time).format(context)}",
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          color: Theme.of(context).primaryColorDark,
                          onPressed: () =>
                              editInformation(_appointments[index].id),
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
          style: Theme.of(context).textTheme.headline4,
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
