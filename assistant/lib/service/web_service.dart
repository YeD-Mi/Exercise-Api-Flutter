import 'package:assistant/constant/baglanti.dart';
import 'package:http/http.dart' as http;
import '../model/exercise.dart';

class WebService {
  Future<List<Exercise>> fetchExercises() async {
    Uri uri = Uri.parse(Baglanti.Api);
    final response = await http.get(uri, headers: Baglanti.headers);
    if (response.statusCode == 200) {
      print('Basarili...');
      return exerciseFromJson(response.body);
    }
    return [];
  }
}
