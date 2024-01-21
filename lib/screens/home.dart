// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:cipa_care_app/constants/constants.dart';
import 'package:cipa_care_app/helpers/degrees_helper.dart';
import 'package:cipa_care_app/models/temprature.dart';
import 'package:cipa_care_app/services/firebase_service.dart';
import 'package:cipa_care_app/widgets/add_test_button.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Temperature> temperatures = [];
  RecommendationData recommendation =
      RecommendationData(text: "", imagePath: "");

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateRecommendation();
  }

  Future<void> fetchDataAndUpdateRecommendation() async {
    try {
      List<Temperature> fetchedTemperatures =
          await FirebaseService().fetchData();

      //Sort the temperatures based on timestamp in descending order
      fetchedTemperatures.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));

      setState(() {
        temperatures = List.from(fetchedTemperatures);
        updateRecommendation();
      });
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
  }

  void updateRecommendation() {
    if (temperatures.isNotEmpty) {
      final int latestTemperature = temperatures.first.degree;
      recommendation =
          DegreesHelper.getRecommendation(latestTemperature: latestTemperature);
    } else {
      recommendation = RecommendationData(text: "", imagePath: "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRecommendationWidget(recommendation: recommendation),
            const SizedBox(height: 20.0),
            FetchTestButton(
              onTap: () {
                fetchDataAndUpdateRecommendation();
              },
            ),
            const SizedBox(height: 25.0),
            Text(
              'Latest values picked',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
            const SizedBox(height: 10.0),
            for (var temperature in temperatures)
              _buildTemperatureCard(
                'Degree: ${temperature.degree}\nDate picked: ${_formatTimestamp(temperature.timeStamp)}',
                highlight: temperature == temperatures.first,
              ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}';
  }

  Widget _buildTemperatureCard(String data, {bool highlight = false}) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: highlight ? appBarColor : secondaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white),
      ),
      child: Text(
        data,
        style: TextStyle(
          color: white,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildRecommendationWidget(
      {required RecommendationData recommendation}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Recommendation',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          if (recommendation.text.isNotEmpty)
            Column(
              children: [
                Text(
                  recommendation.text,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                if (recommendation.imagePath.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: cardColor,
                        image: DecorationImage(
                          image: AssetImage(recommendation.imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (recommendation.text.isEmpty)
            const Text(
              'No data available',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
