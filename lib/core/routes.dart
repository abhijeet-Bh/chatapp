import 'package:chatapp/Presentation/views/chat_view.dart';
import 'package:chatapp/Presentation/views/home_view.dart';
import 'package:chatapp/Presentation/views/setuser_view.dart';
import 'package:chatapp/core/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../Presentation/blocs/chatrooms_bloc.dart';

UserInfoService userInfoService = UserInfoService();

final router = GoRouter(
  initialLocation:
      (userInfoService.currentUser == null) ? '/set-user' : '/chat-room',
  routes: [
    GoRoute(
      name: 'setUser',
      path: '/set-user',
      builder: (ctx, state) => const SetUserView(),
    ),
    GoRoute(
      name: 'home',
      path: '/chat-room',
      builder: (ctx, state) => BlocProvider(
        create: (ctx) => ChatRoomsBloc(),
        child: const MyHomePage(),
      ),
    ),
    GoRoute(
      name: 'chat',
      path: '/chat-view',
      builder: (ctx, state) => ChatView(
        room: state.extra as String,
      ),
    ),
  ],
);
