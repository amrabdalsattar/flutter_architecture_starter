part of 'api_cubit.dart';

sealed class ApiState<T> {}

class ApiInitialState<T> implements ApiState<T> {}

class ApiLoadingState<T> implements ApiState<T> {
  final String? message;
  ApiLoadingState({this.message});
}

class ApiSuccessState<T> implements ApiState<T> {
  final T data;
  ApiSuccessState(this.data);
}

class ApiFailureState<T> implements ApiState<T> {
  final String errorMessage;
  ApiFailureState(this.errorMessage);
}
