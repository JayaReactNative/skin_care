part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatLoadEvent extends ChatEvent {}

class ChatClearEvent extends ChatEvent {}

class ChatAddMessageEvent extends ChatEvent {
  final NewMessageModel message;

  const ChatAddMessageEvent({required this.message});
}

class ChatAddImagesEvent extends ChatEvent {}

class ImageAddHistoryEvent extends ChatEvent {}

class FetchImageHistoryEvent extends ChatEvent {}

class StopCalling extends ChatEvent {}
