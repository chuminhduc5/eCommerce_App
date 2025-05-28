import 'package:logger/logger.dart';

var logger = Logger(
  filter: null,
  output: null,
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);

/*
* logger.d("Đây là log debug");  // ℹ️ Debug message - Màu trắng
  logger.i("Đây là log info");   // ℹ️ Info message - Màu xanh
  logger.w("Đây là cảnh báo");   // ⚠️ Warning message - Màu vàng
  logger.e("Đây là lỗi");        // Error message - Màu đỏ
* */
