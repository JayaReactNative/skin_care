import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUserDetail extends ProfileEvent {}
class UpdateUserDetail extends ProfileEvent {
  final dynamic userDetail;

  UpdateUserDetail({required this.userDetail});
  
}
