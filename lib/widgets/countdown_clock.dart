import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({Key? key}) : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late Timer _resetTimer;
  late int _endTime;

  @override
  void initState() {
    super.initState();
    // Set up the initial countdown timer
    _setUpCountdown();
  }

  void _setUpCountdown() {
    // Calculate the initial end time

    setState(() {});
    _endTime = calculateEndTime();

    // Set up a periodic timer to check the countdown
    _resetTimer = Timer.periodic(const Duration(seconds: 1), _resetCountdown);
  }

  void _resetCountdown(Timer timer) {
    // Check if the current time has passed the end time
    if (DateTime.now().millisecondsSinceEpoch > _endTime) {
      // Reset the countdown timer for the next day
      _setUpCountdown();

      // Show a customized dialog for 2 seconds
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_alarm,
                  size: 50,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
                Text(
                  'Time to take your test!',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      );

      // Automatically close the dialog after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(); // Close the dialog
      });
    }
  }

  @override
  void dispose() {
    _resetTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular background for the countdown timer
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 6.0),
              ),
            ),

            // Countdown timer
            CountdownTimer(
              endTime: _endTime,
              endWidget: const Text(
                'Test now!',
                style: TextStyle(fontSize: 16),
              ),
              textStyle: const TextStyle(fontSize: 20, color: Colors.blue),
              onEnd: () {
                _setUpCountdown();
              },
            ),
          ],
        ),
      ),
    );
  }

  int calculateEndTime() {
    DateTime now = DateTime.now();

    // Set test times at 8:00 am, 2:00 pm, and 8:00 pm
    DateTime testTime;
    if (now.hour < 8) {
      testTime = DateTime(now.year, now.month, now.day, 8, 0, 0);
    } else if (now.hour < 14) {
      testTime = DateTime(now.year, now.month, now.day, 14, 0, 0);
    } else if (now.hour < 20) {
      testTime = DateTime(now.year, now.month, now.day, 20, 0, 0);
    } else {
      // If it's already past 8:00 pm, set the countdown for the next day at 8:00 am
      testTime = DateTime(now.year, now.month, now.day + 1, 8, 0, 0);
    }

    return testTime.millisecondsSinceEpoch;
  }
}
