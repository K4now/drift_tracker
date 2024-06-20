import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SessionDetailPage extends StatelessWidget {
  final String sessionId;

  const SessionDetailPage({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: Text('Session Details')),
      body: Center(
        child: isPortrait ? PortraitSessionDetail(sessionId: sessionId) : LandscapeSessionDetail(sessionId: sessionId),
      ),
    );
  }
}

class PortraitSessionDetail extends StatelessWidget {
  final String sessionId;

  const PortraitSessionDetail({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Details for session: $sessionId', style: TextStyle(fontSize: 20)),
      ],
    );
  }
}

class LandscapeSessionDetail extends StatelessWidget {
  final String sessionId;

  const LandscapeSessionDetail({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text('Details for session: $sessionId', style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }
}
