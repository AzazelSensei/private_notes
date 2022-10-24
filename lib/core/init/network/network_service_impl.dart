import 'package:dio/dio.dart' as dio;
import 'package:private_notes/core/init/network/domain/network_model.dart';
import 'package:private_notes/core/init/network/domain/network_service.dart';

class NetworkServiceClient
    with dio.DioMixin
    implements dio.Dio, NetworkService {
  @override
  Future<R> dioGet<T extends NetworkModel, R>(String endpoint,
      {Map<String, dynamic>? query, required T networkModel}) {
    throw UnimplementedError();
  }

  @override
  Future<R> dioPost<T extends NetworkModel, R>(String endpoint,
      {Map<String, dynamic>? query, required T networkModel, body}) {
    throw UnimplementedError();
  }

  @override
  dio.Interceptor get dioIntercepters => throw UnimplementedError();
}
