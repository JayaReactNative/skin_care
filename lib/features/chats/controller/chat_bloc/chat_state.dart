part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure }

class ChatState {
  const ChatState({
    required this.status,
    this.error,
  });

  final ChatStatus status;
  final String? error;

  // @override
  // List<Object?> get props => [status, error];

  ChatState copyWith({
    ChatStatus? status,
    String? error,
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error,
    );
  }
}

class ChatLoadedState extends ChatState {
  const ChatLoadedState({
    required super.status,
    required this.chatMessages,
  });
  final ChatModel chatMessages;
}

class ImageHistoryState extends ChatState {
  ImageHistoryState({required super.status, required this.chatimage});
  final List<ImagesDetails> chatimage;
}
