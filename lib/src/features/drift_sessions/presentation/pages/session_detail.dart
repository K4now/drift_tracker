import '../../domain/entities/session.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SessionDetailPage extends StatelessWidget {
  final Session session;

  const SessionDetailPage({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(title: Text('Session Details')),
      body: Center(
        child: isPortrait ? PortraitSessionDetail(session: session) : LandscapeSessionDetail(session: session),
      ),
    );
  }
}

class PortraitSessionDetail extends StatelessWidget {
  final Session session;

  const PortraitSessionDetail({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Session ID: ${session.id}', style: TextStyle(fontSize: 20)),
        Text('Max Angle: ${session.maxAngle}', style: TextStyle(fontSize: 20)),
        Text('Points: ${session.points}', style: TextStyle(fontSize: 20)),
        Text('Average Speed: ${session.averageSpeed}', style: TextStyle(fontSize: 20)),
        // Add other session details here
      ],
    );
  }
}

class LandscapeSessionDetail extends StatelessWidget {
  final Session session;

  const LandscapeSessionDetail({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Session ID: ${session.id}', style: TextStyle(fontSize: 20)),
                Text('Max Angle: ${session.maxAngle}', style: TextStyle(fontSize: 20)),
                Text('Points: ${session.points}', style: TextStyle(fontSize: 20)),
                Text('Average Speed: ${session.averageSpeed}', style: TextStyle(fontSize: 20)),
                // Add other session details here
              ],
            ),
          ),
        ),
      ],
    );
  }
}
