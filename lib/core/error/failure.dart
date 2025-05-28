import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataInputFailure extends Failure {}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class UnexpectedFailure extends Failure {}

class ConnectionFailure extends Failure {}

class DatabaseFailure extends Failure {}

class CacheFailure extends Failure {}

class EmptyFailure extends Failure {}

class CredentialFailure extends Failure {}

class DuplicateEmailFailure extends Failure {}

class PasswordNotMatchFailure extends Failure {}

class InvalidEmailFailure extends Failure {}

class InvalidPasswordFailure extends Failure {}
