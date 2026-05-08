import 'package:dio/dio.dart';

import 'api_request_model.dart';

abstract class ApiHelper {
  Future<Response> getData(ApiRequestModel requestModel);
  Future<Response> postData(ApiRequestModel requestModel);
  Future<Response> deleteData(ApiRequestModel requestModel);
  Future<Response> patchData(ApiRequestModel requestModel);
  Future<Response> putData(ApiRequestModel requestModel);
}

class DioHelperImpl implements ApiHelper {
  final Dio _dio;
  const DioHelperImpl(this._dio);

  @override
  Future<Response> getData(ApiRequestModel requestModel) {
    return _dio.get(
      requestModel.endPoint,
      data: requestModel.data,
      options: requestModel.options,
      queryParameters: requestModel.queries,
    );
  }

  @override
  Future<Response> postData(ApiRequestModel requestModel) {
    return _dio.post(
      requestModel.endPoint,
      data: requestModel.data,
      options: requestModel.options,
      queryParameters: requestModel.queries,
    );
  }

  @override
  Future<Response> deleteData(ApiRequestModel requestModel) {
    return _dio.delete(
      requestModel.endPoint,
      data: requestModel.data,
      options: requestModel.options,
      queryParameters: requestModel.queries,
    );
  }

  @override
  Future<Response> patchData(ApiRequestModel requestModel) {
    return _dio.patch(
      requestModel.endPoint,
      data: requestModel.data,
      options: requestModel.options,
      queryParameters: requestModel.queries,
    );
  }

  @override
  Future<Response> putData(ApiRequestModel requestModel) {
    return _dio.put(
      requestModel.endPoint,
      data: requestModel.data,
      options: requestModel.options,
      queryParameters: requestModel.queries,
    );
  }
}
