import 'package:chatapp/domain/repositories/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRepositoryImpl extends ChatRepository {
  //Firebase Instance
  final FirebaseDatabase database = FirebaseDatabase.instance;

  //List of Rooms
  List<String> allRooms = [];

  @override
  Future<List<String>> getChatRooms() async {
    try {
      final snapshot = await database.ref('chat_rooms').get();
      if (snapshot.exists) {
        var rooms = snapshot.children;
        for (var child in rooms) {
          allRooms.add(child.key!);
        }
      }
      return allRooms;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
