// Modify the DegreesHelper
import 'package:cipa_care_app/services/assets_manager.dart';

class DegreesHelper {
  static RecommendationData getRecommendation(
      {required int latestTemperature}) {
    if (latestTemperature < 25) {
      return RecommendationData(
        text: 'Wear a winter jacket',
        imagePath: AssetsManager.winterjacket,
      );
    } else if (latestTemperature < 45) {
      return RecommendationData(
        text: 'Wear a light to medium coat',
        imagePath: AssetsManager.lighttomedium,
      );
    } else if (latestTemperature < 65) {
      return RecommendationData(
        text: 'Wear Fleece',
        imagePath: AssetsManager.fleece,
      );
    } else if (latestTemperature < 80) {
      return RecommendationData(
        text: 'Wear short sleeves',
        imagePath: AssetsManager.shortsleeves,
      );
    } else {
      return RecommendationData(
        text: 'Wear shorts',
        imagePath: AssetsManager.shorts,
      );
    }
  }
}

// Create a class to hold both text and image path
class RecommendationData {
  final String text;
  final String imagePath;

  RecommendationData({required this.text, required this.imagePath});
}
