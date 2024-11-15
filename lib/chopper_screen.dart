import 'package:flutter/material.dart';
import 'chopper_service.dart';

class ChopperScreen extends StatelessWidget {
  final chopperService = ChopperService.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chopper Data")),
      body: FutureBuilder(
        future: chopperService.fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final List<dynamic> data = snapshot.data!.body;
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

class LoggingInterceptor implements RequestInterceptor, ResponseInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    print("Request: ${request.method} ${request.url}");
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    print("Response: ${response.statusCode}");
    return response;
  }
}

final client = ChopperClient(
  interceptors: [LoggingInterceptor()],
);

class CustomConverter extends JsonConverter {
  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    final modifiedResponse = response.copyWith(
        body: response.body.map((item) => item['title']).toList());
    return super.convertResponse(modifiedResponse);
  }
}

final client = ChopperClient(
  converter: CustomConverter(),
);
