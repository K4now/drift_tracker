import 'package:drift_tracker/src/features/leaderboard/data/models/leaderboard_entry.dart';

abstract class LeaderboardState {}

class LeaderboardLoading extends LeaderboardState {}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> entries;

  LeaderboardLoaded(this.entries);
}

class LeaderboardError extends LeaderboardState {
  final String message;

  LeaderboardError(this.message);
}