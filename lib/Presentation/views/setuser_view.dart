import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/user_service.dart';

class SetUserView extends StatefulWidget {
  const SetUserView({super.key});

  @override
  State<SetUserView> createState() => _SetUserViewState();
}

final TextEditingController userController = TextEditingController();
final UserInfoService userInfoService = UserInfoService();

class _SetUserViewState extends State<SetUserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Who are You?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: userController,
              decoration: const InputDecoration(
                fillColor: Colors.black12,
                filled: true,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                userInfoService.setCurrentUser(userController.text);
                userController.clear();
                context.go('/chat-room');
              },
            )
          ],
        ),
      ),
    );
  }
}
