import 'package:http/http.dart' as http;

class HttpClientClass {
  final http.Client _client;

  HttpClientClass({required http.Client client}) : _client = client;

  Future<http.Response> get(String url) async {
    final uri = Uri.parse(url);
    final response = await _client.get(uri);
    return response;
  }
}
