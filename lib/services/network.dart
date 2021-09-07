import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Network({required this.url});
  late final String url;

  Future networkHelp() async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }
}
