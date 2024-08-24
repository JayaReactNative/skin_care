import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:skin_care/core/constants/constant.dart';
import 'package:skin_care/core/repository.dart';
import 'package:skin_care/dependency_injection.dart';
import 'package:skin_care/features/Profile/controller/profile_bloc.dart';
import 'package:skin_care/features/Profile/controller/profile_event.dart';
import 'package:skin_care/features/auth/controller/auth_events.dart';
import 'package:skin_care/features/auth/controller/auth_state.dart';
import 'package:skin_care/shared/dynamictoast.dart';

import '../repo/repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String gender = "Male";
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  // otp controller
  OtpFieldController otpController = OtpFieldController();
  String? otp;
  String? authid;
  bool done = false;

  AuthBloc()
      : super(AuthState(
          authStatus: AuthStatus.failed,
          status: IsLoading.success,
        )) {
    on<LoginAuth>(login);
    on<SignupAuth>(signup);
    on<ForgetPasswordAuth>(forgetpassword);
    on<EnterOtpAuth>(otpVerification);
    on<ChangePasswordAuth>(changePassword);
    on<ResponseStatusAuth>(responsestatus);
  }

  // dispose controller
  void disposecontrollers() {
    emailcontroller.clear();
    passwordcontroller.clear();
    firstName.clear();
    lastName.clear();
    phoneNumber.clear();
    confirmpassword.clear();
  }

  // login user

  Future<void> login(LoginAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: IsLoading.loading));

      final response = await Authrepo.login(
          emailcontroller.text.trim(), passwordcontroller.text.trim());
      log(response.toString());
      if (response['subCode'] == 200) {
        emit(state.copyWith(authStatus: AuthStatus.success));
        DynamicToast.show(response['message']);
        storage.write('userid', response['items']['userId']);
        storage.write('token', response['items']['token']);
        storage.write('islogin', true);

        disposecontrollers();
      } else {
        DynamicToast.show(response['message']);
        emit(state.copyWith(authStatus: AuthStatus.failed));
      }
    } catch (e) {
      DynamicToast.show('$e');
      emit(state.copyWith(authStatus: AuthStatus.failed));
    } finally {
      emit(state.copyWith(status: IsLoading.success));
    }
  }

  // register user
  // Signup API method
  Future<void> signup(SignupAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: IsLoading.loading));

      final response = await Authrepo.signup(
          firstName.text,
          lastName.text,
          phoneNumber.text,
          emailcontroller.text,
          passwordcontroller.text,
          confirmpassword.text,
          gender);
      log(response.toString());
      if (response['subCode'] == 200) {
        emit(state.copyWith(authStatus: AuthStatus.success));
        DynamicToast.show(response['message']);
        disposecontrollers();
      } else {
        DynamicToast.show(response['message']);
        emit(state.copyWith(authStatus: AuthStatus.failed));
      }
    } catch (e) {
      DynamicToast.show('Something went Wrong: $e ');
      emit(state.copyWith(authStatus: AuthStatus.failed));
    } finally {
      emit(state.copyWith(status: IsLoading.success));
    }
  }

  // forget password
  Future<void> forgetpassword(
      ForgetPasswordAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: IsLoading.loading));

      final response =
          await Authrepo.forgetpassword(emailcontroller.text.trim());
      if (response['subCode'] == 200) {
        emit(state.copyWith(authStatus: AuthStatus.success));
        storage.write(
            'email', response['items']['existDetails']['email'].toString());
        DynamicToast.show(response['message']);
        disposecontrollers();
        // Password reset was successful
      } else {
        DynamicToast.show(response['message']);
        emit(state.copyWith(authStatus: AuthStatus.failed));
        // Password reset failed
      }
    } catch (e) {
      DynamicToast.show('$e');
      emit(state.copyWith(authStatus: AuthStatus.failed));
    } finally {
      emit(state.copyWith(status: IsLoading.success));
    }
  }

  // enter otp to forget password
  Future<void> otpVerification(
      EnterOtpAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: IsLoading.loading));

      final response = await Authrepo.otpverification(otp!);
      if (response['subCode'] == 200) {
        authid = response['items']['_id'];
        emit(state.copyWith(authStatus: AuthStatus.success));
        DynamicToast.show(response['message']);
        disposecontrollers();
      } else {
        DynamicToast.show(response['message']);
        emit(state.copyWith(authStatus: AuthStatus.failed));
        // Password reset failed
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {
      emit(state.copyWith(status: IsLoading.success));
    }
  }

  Future<void> changePassword(
      ChangePasswordAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: IsLoading.loading));

      final response = await Authrepo.changepassword(
          authid!, passwordcontroller.text.trim(), confirmpassword.text.trim());
      log(response.toString());
      if (response['subCode'] == 200) {
        emit(state.copyWith(authStatus: AuthStatus.success));
        DynamicToast.show(response['message']);
        disposecontrollers();
      } else {
        DynamicToast.show(response['message']);
        emit(state.copyWith(authStatus: AuthStatus.failed));
      }
    } catch (e) {
      DynamicToast.show('$e');
      emit(state.copyWith(authStatus: AuthStatus.failed));
    } finally {
      emit(state.copyWith(status: IsLoading.success));
    }
  }

  void responsestatus(ResponseStatusAuth event, Emitter<AuthState> emit) {
    emit(state.copyWith(authStatus: AuthStatus.failed));
  }
}
