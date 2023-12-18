import 'package:chatapp/Presentation/blocs/chatrooms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Chat Rooms"),
      ),
      body: BlocBuilder<ChatRoomsBloc, ChatRoomsState>(
        builder: (ctx, state) {
          if (state is ChatRoomsInitial) {
            BlocProvider.of<ChatRoomsBloc>(context).add(LoadChatRooms());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatRoomsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChatRoomsLoaded) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Text(
                              state.rooms[index]!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        // onTap: () {
                        //   Navigator.pushNamed(
                        //     context,
                        //     '/chat',
                        //     arguments: {'roomName': state.rooms[index]!},
                        //   );
                        // },
                        onTap: () => context.pushNamed(
                          'chat',
                          extra: state.rooms[index],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: state.rooms.length,
              ),
            );
          } else {
            return const Center(
              child: Text("Something went wrong!"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
