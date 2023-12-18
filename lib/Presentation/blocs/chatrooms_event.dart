part of 'chatrooms_bloc.dart';

abstract class ChatRoomsEvent extends Equatable {
  const ChatRoomsEvent();
}

class LoadChatRooms extends ChatRoomsEvent {
  @override
  List<Object> get props => [];
}
