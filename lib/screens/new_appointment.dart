import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class NewAppointment extends StatefulWidget {
  final Function newAppointment;

  NewAppointment(this.newAppointment);

  @override
  _NewAppointmentState createState() => _NewAppointmentState();
}

class _NewAppointmentState extends State<NewAppointment> {
  String _selectedType;
  // String _selectedType = "Odontología";
  final _place = TextEditingController();
  final _additionalInformation = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  List<String> types = <String>[
    'Enfermería',
    'Fisioterapia',
    'Fonoaudiología',
    'Medicina especializada',
    'Medicina general',
    'Nutrición',
    'Odontología',
    'Odontología especializada',
    'Optometría',
    'Psicología',
    'Química farmacéutica',
    'Terapia ocupacional',
    'Terapia respiratoria',
  ];

  void _submitData() {
    final selectedPlace = _place.text;
    final selectedAdditionalInformation = _additionalInformation.text;

    if (_selectedDate == null || _selectedTime == null || selectedPlace == '') {
      return;
    }

    widget.newAppointment(
      _selectedType,
      selectedPlace,
      selectedAdditionalInformation,
      _selectedDate,
      _selectedTime,
    );

    Navigator.of(context).pop();
  }

  void _selectDate() {
    DateTime dateTimeNow = DateTime.now();
    showDatePicker(
      context: context,
      initialDate: dateTimeNow,
      firstDate: dateTimeNow.subtract(Duration(days: 900)),
      lastDate: dateTimeNow.add(Duration(days: 900)),
    ).then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });
    });

    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((selectedTime) {
      if (selectedTime == null) {
        return;
      }
      setState(() {
        _selectedTime = selectedTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //SELECT PLACE
            Container(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _place,
                decoration: InputDecoration(
                  labelText: "Lugar",
                  helperText: "Ejemplo: HGM, IPS CES Sabaneta",
                ),
                onSubmitted: (_) => _submitData(),
              ),
              padding: EdgeInsets.fromLTRB(5, 14, 5, 10),
            ),

            //SELECT TYPE OF ATTENTION
            SizedBox(
              height: 10.0,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Container(
                      width: 150, //and here
                      child: Text(
                        "Tipo de cita",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    value: _selectedType,
                    onChanged: (selection) {
                      setState(() {
                        _selectedType = selection;
                      });
                    },
                    items: types.map((String type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(
                          type,
                          textAlign: TextAlign.start,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            //DATE
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Aún no has elegido fecha!"
                          : "Fecha: ${DateFormat.yMd().format(_selectedDate)}",
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Elegir fecha y hora",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _selectDate,
                  )
                ],
              ),
            ),

            //ADDITIONAL INFO
            Container(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _additionalInformation,
                decoration: InputDecoration(
                  labelText: 'Información adicional (opcional)',
                  helperText: 'Ejemplo: Nombre del profesional de salud.',
                ),
                onSubmitted: (_) => _submitData(),
              ),
              padding: EdgeInsets.all(5),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: Text('Añadir cita'),
                    onPressed: _submitData,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
