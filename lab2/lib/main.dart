import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Age Calculator'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: const AgePage(),
      ),
    ),
  );
}

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  AgePageState createState() => AgePageState();
}

class AgePageState extends State<AgePage> {
  DateTime _dateOfBirth = DateTime.now();
  int _age = 0;
  int _months = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Date of Birth', style: TextStyle(fontSize: 28),),
            TextButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dateOfBirth,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _dateOfBirth = date;
                    _age = DateTime.now().year - _dateOfBirth.year;
                    _months = DateTime.now().month - _dateOfBirth.month;
                  });
                }
              },
              child: Text('${_dateOfBirth.day}-${_dateOfBirth.month}-${_dateOfBirth.year}', style: const TextStyle(fontSize: 28),), // Interpolation
            ),
            const Text(' Years', style: TextStyle(fontSize: 28),),
            Text(_age.toString(), style: const TextStyle(fontSize: 28),),
            const Text(' Months', style: TextStyle(fontSize: 28),),
            Text(_months.toString(), style: const TextStyle(fontSize: 28),),
          ],
        ),
      ),
    );
  }
}
