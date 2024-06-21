import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_event.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_state.dart';
import 'package:drift_tracker/src/routes/app_router.gr.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, state) {
          if (state is LeaderboardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LeaderboardLoaded) {
            final entries = state.entries;
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return ListTile(
                  title: Text('${entry.userId} (${entry.carModel})'),
                  subtitle: Text('Score: ${entry.score}, Date: ${entry.date}'),
                );
              },
            );
          } else {
            return Center(child: Text('Failed to load leaderboard.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.router.push(AddLeaderboardEntryRoute());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
