import 'package:cloud_firestore/cloud_firestore.dart';

class Temperature {
  int degree;
  DateTime timeStamp;

  Temperature({
    required this.degree,
    required this.timeStamp,
  });

  factory Temperature.fromMap(Map<String, dynamic> map) {
    return Temperature(
      degree: map['degree'] ?? 0,
      timeStamp: (map['timeStamp'] as Timestamp).toDate(),
    );
  }
}
