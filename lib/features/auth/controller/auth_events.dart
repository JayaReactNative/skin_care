import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class LoginAuth extends AuthEvent {}

class SignupAuth extends AuthEvent {}

class ForgetPasswordAuth extends AuthEvent {}

class EnterOtpAuth extends AuthEvent {}

class ChangePasswordAuth extends AuthEvent {}

class ResponseStatusAuth extends AuthEvent {}

