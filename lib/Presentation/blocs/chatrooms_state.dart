part of 'chatrooms_bloc.dart';

abstract class ChatRoomsState extends Equatable {
  const ChatRoomsState();
}

class ChatRoomsInitial extends ChatRoomsState {
  @override
  List<Object> get props => [];
}

class ChatRoomsLoading extends ChatRoomsState {
  @override
  List<Object> get props => [];
}

class ChatRoomsLoaded extends ChatRoomsState {
  final List<String?> rooms;

  const ChatRoomsLoaded(this.rooms);
  @override
  List<Object> get props => [];
}

class ChatRoomsLoadingError extends ChatRoomsState {
  @override
  List<Object> get props => [];
}
