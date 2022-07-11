import 'package:http/http.dart' as http;

class NetworkHelper {

  Future<http.Response> get(String url) async {
    var response = await http.get(Uri.parse(url));
    return response;
  }
}