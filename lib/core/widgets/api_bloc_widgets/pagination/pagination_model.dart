import 'package:equatable/equatable.dart';

abstract class PaginationModel extends Equatable {
  final int pageNumber;
  final int pageSize;

  const PaginationModel({required this.pageNumber, this.pageSize = 10});

  Map<String, dynamic> toPaginationJson() => {
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}

class BasePaginationModel extends PaginationModel {
  const BasePaginationModel({required super.pageNumber, super.pageSize});

  @override
  List<Object?> get props => [pageSize];
}
