part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, success, failure }

class SplashState extends Equatable {
  const SplashState({
    required this.status,
    this.error,
  });

  final SplashStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, error];

  SplashState copyWith({
    SplashStatus? status,
    String? error,
  }) {
    return SplashState(
      status: status ?? this.status,
      error: error,
    );
  }
}