import 'package:chatapp/data/repositories/chat_repository_impl.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/chat_repository.dart';

part 'chatrooms_event.dart';
part 'chatrooms_state.dart';

class ChatRoomsBloc extends Bloc<ChatRoomsEvent, ChatRoomsState> {
  final ChatRepository chatRepo = ChatRepositoryImpl();

  ChatRoomsBloc() : super(ChatRoomsInitial()) {
    on<ChatRoomsEvent>((event, emit) async {
      if (event is LoadChatRooms) {
        try {
          List<String?> allRooms = await chatRepo.getChatRooms();
          emit(ChatRoomsLoaded(allRooms));
        } catch (e) {
          emit(ChatRoomsLoadingError());
        }
      } else {
        emit(ChatRoomsLoadingError());
      }
    });
  }
}
