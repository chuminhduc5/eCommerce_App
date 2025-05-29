

import 'package:ecommerce_app/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  return switch (failure) {
    ServerFailure() => "Lỗi máy chủ",
    CacheFailure() => "Lỗi bộ nhớ đệm",
    EmptyFailure() => "Lỗi trống",
    CredentialFailure() => "Email hoặc mật khẩu không chính xác",
    DuplicateEmailFailure() => "Email đã được sử dụng. Vui lòng sử dụng email khác!",
    PasswordNotMatchFailure() => "Mật khẩu không khớp",
    InvalidEmailFailure() => "Định dạng email không hợp lệ",
    InvalidPasswordFailure() => "Định dạng mật khẩu không hợp lệ",
    DataInputFailure() => "Dữ liệu nhập vào không chính xác",
    NetworkFailure() => "Lỗi kết nối mạng",
    ConnectionFailure() => "Lỗi kết nối, kết nối thất bại",
    _ => "Lỗi",
  };
}