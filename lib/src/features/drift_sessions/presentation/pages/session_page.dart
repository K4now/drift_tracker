import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../bloc/session_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';
import '../../../../../generated/l10n.dart';

@RoutePage()
class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  void _loadSessions() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<SessionBloc>().add(GetSessionsEvent(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).session),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadSessions,
          ),
        ],
      ),
      body: BlocListener<SessionBloc, SessionState>(
        listener: (context, state) {
          if (state is SessionError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SessionDeleted) {
            _loadSessions();
          }
        },
        child: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is SessionLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SessionLoaded) {
              return ListView.builder(
                itemCount: state.sessions.length,
                itemBuilder: (context, index) {
                  final session = state.sessions[index];
                  return Dismissible(
                    key: Key(session.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm'),
                            content: Text('Do you really want to delete this session?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      context.read<SessionBloc>().add(DeleteSessionEvent(session.id));
                    },
                    child: ListTile(
                      title: Text('Session ${session.id}'),
                      subtitle: Text('Max Angle: ${session.maxAngle}, Points: ${session.points}, Avg Speed: ${session.averageSpeed}'),
                      onTap: () {
                        context.router.push(SessionDetailRoute(session: session));
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No sessions available'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.router.push(UserMeasurementRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
