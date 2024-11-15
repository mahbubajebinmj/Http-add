import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<dynamic>> fetchData() async {
    final response =
        await http.get(Uri.parse(url), headers: {"Custom-Header": "Value"});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
