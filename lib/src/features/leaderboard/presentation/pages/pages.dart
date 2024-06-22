import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_event.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_state.dart';
@RoutePage()
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
          } else if (state is LeaderboardError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No leaderboard data available'));
          }
        },
      ),
    );
  }
}
