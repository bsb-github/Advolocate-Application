import 'package:flutter/material.dart';

class ProfilePending extends StatelessWidget {
  const ProfilePending({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Profile Under Review",
              style: TextStyle(
                fontSize: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
