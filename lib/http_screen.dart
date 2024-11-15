import 'package:flutter/material.dart';
import 'http_service.dart';

class HttpScreen extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP Data")),
      body: FutureBuilder(
        future: httpService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final List<dynamic> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['title']),
                  subtitle: Text("ID: ${data[index]['id']}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
