import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiRequestModel extends Equatable {
  final String endPoint;
  final Map<String, dynamic>? _headers;
  final Map<String, dynamic>? _body;
  final FormData? _formBody;
  final Map<String, dynamic>? queries;
  final ResponseType? _responseType;
  final Duration? _receiveTimeout;

  const ApiRequestModel({
    FormData? formBody,
    required this.endPoint,
    ResponseType? responseType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    this.queries,
    Duration? receiveTimeout,
  }) : _receiveTimeout = receiveTimeout,
       _responseType = responseType,
       _headers = headers,
       _body = body,
       _formBody = formBody;

  Object? get data => _formBody ?? _body;

  Options get options => Options(
    headers: _headers,
    responseType: _responseType,
    receiveTimeout: _receiveTimeout,
  );

  @override
  List<Object?> get props => [
    endPoint,
    _headers,
    _body,
    queries,
    _responseType,
    _receiveTimeout,
  ];
}
