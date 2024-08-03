import 'package:bitcointicker/Utilities/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class NetworkHelper {

  Future<dynamic> getCurrencyData({required String crypto,required String currency}) async {
    var url = Uri.parse('$apiUrl/$crypto/$currency?apikey=$apiKey');
    print(url);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}