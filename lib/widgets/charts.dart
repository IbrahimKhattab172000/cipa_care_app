import 'package:cipa_care_app/models/temprature.dart';
import 'package:cipa_care_app/services/firebase_service.dart';
import 'package:cipa_care_app/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  const Charts({Key? key}) : super(key: key);

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Temperature>>(
      stream: _firebaseService.temperatureStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<Temperature> data = snapshot.data!;

        print('Received Data: $data'); // Print received data for debugging.

        return Column(
          children: [
            LineChart(
              title: 'Degrees',
              data: data,
              color: Colors.white,
            ),
          ],
        );
      },
    );
  }
}
