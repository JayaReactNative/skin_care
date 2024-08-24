import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_events.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      : super(const SplashState(
          status: SplashStatus.initial,
        )) {
    on<SplashInitEvent>((event, emit) => _initMethod(event, emit));
  }

  _initMethod(event, emit) async {
    log("Initial method called");
    await Future.delayed(
      const Duration(seconds: 1),
    );
    emit(
      const SplashState(
        status: SplashStatus.success,
      ),
    );
  }
}
