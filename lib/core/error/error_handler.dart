import 'dart:io';

import 'package:dio/dio.dart';

class AppError {
  final String message;

  AppError(this.message);

  @override
  String toString() => message;
}

class ErrorHandler {
  static String handleError(Exception error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Kết nối tới máy chủ bị hết thời gian';
        case DioExceptionType.sendTimeout:
          return 'Không thể gửi yêu cầu tới máy chủ';
        case DioExceptionType.receiveTimeout:
          return 'Không nhận được phản hồi từ máy chủ';
        case DioExceptionType.badResponse:
          return 'Lỗi máy chủ (${error.response?.statusCode}): ${error.response?.statusMessage}';
        case DioExceptionType.cancel:
          return 'Yêu cầu đã bị hủy';
        default:
          return 'Lỗi mạng không xác định';
      }
    } else if (error is SocketException) {
      return 'Không có kết nối mạng';
    } else {
      return 'Đã xảy ra lỗi không xác định';
    }
  }
}
