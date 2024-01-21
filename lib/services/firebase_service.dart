import 'package:cipa_care_app/models/temprature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Temperature>> temperatureStream() {
    return _firestore
        .collection('temperatures') // Replace with your collection name
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Temperature.fromMap(doc.data()))
            .toList());
  }

  Future<void> addData(Temperature temprature) async {
    await _firestore.collection('temperatures').add({
      'degree': temprature.degree,
      'timeStamp': temprature.timeStamp,
    });
  }

  Future<List<Temperature>> fetchData() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection('temperatures').get();

    return querySnapshot.docs.map((DocumentSnapshot doc) {
      return Temperature(
        degree: doc['degree'],
        timeStamp: doc['timeStamp'].toDate(),
      );
    }).toList();
  }
}
