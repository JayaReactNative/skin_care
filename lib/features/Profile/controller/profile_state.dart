import '../model/updated_profile_model.dart';
import '../model/user_profile_model.dart';

class ProfileState {}

class ProfilLoadedState extends ProfileState {
  final AuthDetails? authDetails;
  final List<Item> userdata;

  ProfilLoadedState({
    required this.authDetails,
    required this.userdata,
  });
}

class ProfileUpdatedState extends ProfileState {
  final UpdatedUserProfileData? authDetail;

  ProfileUpdatedState({
    required this.authDetail,
  });
}
