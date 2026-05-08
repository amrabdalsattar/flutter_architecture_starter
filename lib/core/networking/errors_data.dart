part of 'api_error_handler.dart';

// DO NOT edit enum DataSource values without as it's based DioExceptionType values
enum DataSource {
  noContent,
  badRequest,
  unAuthorized,
  forbidden,
  internalServerError,
  notFound,
  apiLogicError,
  serverFailure,
  badGateway,

  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  parsingError,
  requestEntityTooLarge,

  defaultError,
}

extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() => _errorsData[this]!;
}

Map<DataSource, ApiErrorModel> get _errorsData => <DataSource, ApiErrorModel>{
  DataSource.noContent: ApiErrorModel(
    code: 201,
    message: LocaleKeys.errors.noContent,
  ),
  DataSource.badRequest: ApiErrorModel(
    code: 400,
    message: LocaleKeys.errors.badRequest,
  ),

  DataSource.unAuthorized: ApiErrorModel(
    code: 401,
    message: LocaleKeys.errors.unAuthorized,
  ),

  DataSource.forbidden: ApiErrorModel(
    code: 403,
    message: LocaleKeys.errors.forbidden,
  ),
  DataSource.notFound: ApiErrorModel(
    code: 404,
    message: LocaleKeys.errors.notFound,
  ),
  DataSource.requestEntityTooLarge: ApiErrorModel(
    code: 413,
    message: LocaleKeys.errors.requestEntityTooLarge,
  ),

  DataSource.internalServerError: ApiErrorModel(
    code: 500,
    message: LocaleKeys.errors.internalServerError,
  ),
  DataSource.serverFailure: ApiErrorModel(
    code: 502,
    message: LocaleKeys.errors.serverFailure,
  ),
  DataSource.badGateway: ApiErrorModel(
    code: 503,
    message: LocaleKeys.errors.badGateway,
  ),

  DataSource.apiLogicError: ApiErrorModel(
    code: 422,
    message: LocaleKeys.errors.apiLogicError,
  ),

  DataSource.connectionTimeout: ApiErrorModel(
    code: -1,
    message: LocaleKeys.errors.connectionTimeout,
  ),

  DataSource.cancel: ApiErrorModel(code: -2, message: LocaleKeys.common.cancel),

  DataSource.receiveTimeout: ApiErrorModel(
    code: -3,
    message: LocaleKeys.errors.receiveTimeout,
  ),

  DataSource.sendTimeout: ApiErrorModel(
    code: -4,
    message: LocaleKeys.errors.sendTimeout,
  ),

  DataSource.cacheError: ApiErrorModel(
    code: -5,
    message: LocaleKeys.errors.cacheError,
  ),

  DataSource.noInternetConnection: ApiErrorModel(
    code: -6,
    message: LocaleKeys.errors.noInternetConnection,
  ),
  DataSource.parsingError: ApiErrorModel(
    code: -7,
    message: LocaleKeys.errors.parsingError,
  ),

  DataSource.defaultError: ApiErrorModel(
    code: -8,
    message: LocaleKeys.errors.defaultError,
  ),

  // Add your custom errors here
};
