// ignore_for_file: avoid_print

import 'package:cipa_care_app/constants/constants.dart';
import 'package:cipa_care_app/widgets/charts.dart';
import 'package:cipa_care_app/widgets/countdown_clock.dart';
import 'package:flutter/material.dart';

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Next test should be in',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            const SizedBox(height: 10.0),
            const CountDownWidget(),
            const SizedBox(height: 20.0),
            const Charts(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}


//TODO: let's add a listener once any data is added to the firebase to apply those chnages instantly on the charts
//Todo...make sure if that's done here you add it as well to the capstone app.
