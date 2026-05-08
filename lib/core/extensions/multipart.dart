import 'dart:io';

import 'package:dio/dio.dart';

extension ToMultipartFile on File {
  MultipartFile toMultipartFile() {
    return MultipartFile.fromFileSync(path);
  }
}

extension ToMultipartFiles on List<File> {
  List<MultipartFile> toMultipartFiles() {
    return map((file) => file.toMultipartFile()).toList();
  }
}
