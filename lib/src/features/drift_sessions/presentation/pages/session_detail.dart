import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SessionDetailPage extends StatelessWidget {
  final String sessionId;

  const SessionDetailPage({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Session Details')),
      body: Center(
        child: Text('Details for session: $sessionId'),
      ),
    );
  }
}
