import '../../data/models/leaderboard_entry.dart';
abstract class LeaderboardEvent {}

class LoadLeaderboard extends LeaderboardEvent {}

class AddLeaderboardEntryEvent extends LeaderboardEvent {
  final LeaderboardEntry entry;

  AddLeaderboardEntryEvent(this.entry);
}
