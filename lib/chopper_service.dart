import 'package:chopper/chopper.dart';

part 'chopper_service.chopper.dart';

@ChopperApi()
abstract class ChopperService extends ChopperService {
  @Get(path: '/posts')
  Future<Response> fetchPosts();

  static ChopperService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$ChopperService()],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Custom-Header': 'Value'})
      ],
    );

    return _$ChopperService(client);
  }
}
