import '../../data/models/leaderboard_entry.dart';

abstract class LeaderboardRepository {
  Stream<List<LeaderboardEntry>> getLeaderboardEntries();
  Future<void> addLeaderboardEntry(LeaderboardEntry entry);
}
