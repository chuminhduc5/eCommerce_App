import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final DateTime? createdAt;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber, createdAt];
}
