import 'package:equatable/equatable.dart';

enum IsLoading { loading, success }

enum AuthStatus { success, failed }

class AuthState extends Equatable {
  AuthState({required this.status, required this.authStatus});
  IsLoading status;
  AuthStatus authStatus;
  @override
  // TODO: implement props
  List<Object?> get props => [status, authStatus];
  AuthState copyWith({IsLoading? status, AuthStatus? authStatus}) {
    return AuthState(
        status: status ?? this.status,
        authStatus: authStatus ?? this.authStatus);
  }
}
