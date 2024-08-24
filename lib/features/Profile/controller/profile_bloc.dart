import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skin_care/dependency_injection.dart';
import 'package:skin_care/features/Profile/repo/profilerepository.dart';

import '../../../core/constants/constant.dart';
import '../../../core/repository.dart';
import '../../../shared/dynamictoast.dart';
import '../model/updated_profile_model.dart';
import '../model/user_profile_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<Item> userdata = [];
  AuthDetails? authDetails;

  ProfileBloc() : super(ProfileState()) {
    // on<GetUserDetail>(getuserdetail);
    on<GetUserDetail>((event, emit) => _getUserDetail(event, emit));
    on<UpdateUserDetail>((event, emit) => _updateUserDetail(event, emit));
  }

  // getuserdetail(
  //     GetUserDetail event, Emitter<ProfileState> state) async {
  //   try {
  //     // emit(state.copyWith(status: IsLoading.loading));

  //     final response = await ProfileRepo.getuserdetail();

  //     // log(response.toString());
  //     if (response['subCode'] == 200) {
  //       DynamicToast.show(response['message']);
  //       UserProfileData userProfileData = UserProfileData.fromJson(response);

  //       userdata = userProfileData.items;
  //       authDetails = userdata[0].authDetails;
  //       emit(ProfilLoadedState(authDetails: authDetails),);

  //       // log(userdata[0].firstName);
  //     } else {
  //       DynamicToast.show(response['message']);

  //       // Password reset failed
  //     }
  //   } catch (e) {
  //     DynamicToast.show('$e');
  //   } finally {
  //     // emit(state.copyWith(status: IsLoading.loading));
  //   }
  // }

  _updateUserDetail(UpdateUserDetail? event, Emitter<ProfileState> emit) async {
    try {
      // emit(state.copyWith(status: IsLoading.loading));

      log("User Detail: ${event!.userDetail}");
      final response = await ProfileRepo.updateUserDetail(event.userDetail);
      DynamicToast.show("Profile updated successfully");

      add(GetUserDetail());
      // log(response.toString());
      // if (response['subCode'] == 200) {
      //   log("Response: ${response}");
      //   // DynamicToast.show(response['message']);
      //   UpdatedUserProfileData userProfileData =
      //       UpdatedUserProfileData.fromJson(response);
      //   log("updateed user detail " +
      //       userProfileData.items.firstName.toString());

      //   emit(
      //     ProfileUpdatedState(
      //       authDetail: userProfileData,
      //     ),
      //   );

      //   Fluttertoast.showToast(msg: "Profile Updated");

      //   // log(userdata[0].firstName);
      // } else {
      //   // DynamicToast.show(response['message']);

      //   // Password reset failed
      // }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {
      // emit(state.copyWith(status: IsLoading.loading));
    }
  }

  _getUserDetail(Object? event, Emitter<ProfileState> emit) async {
    try {
      // emit(state.copyWith(status: IsLoading.loading));

      final response = await ProfileRepo.getuserdetail();

      log("user detail response " + response.toString());
      if (response['subCode'] == 200) {
        // DynamicToast.show(response['message']);
        UserProfileData userProfileData = UserProfileData.fromJson(response);

        userdata = userProfileData.items;
        authDetails = userdata[0].authDetails;
        emit(
          ProfilLoadedState(
            authDetails: authDetails,
            userdata: userdata,
          ),
        );

        // log(userdata[0].firstName);
      } else {
        // DynamicToast.show(response['message']);

        // Password reset failed
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {
      // emit(state.copyWith(status: IsLoading.loading));
    }
  }
}
