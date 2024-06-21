import 'package:drift_tracker/src/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:drift_tracker/src/features/leaderboard/data/models/leaderboard_entry.dart';

class AddLeaderboardEntry {
  final LeaderboardRepository repository;

  AddLeaderboardEntry(this.repository);

  Future<void> call(LeaderboardEntry entry) {
    return repository.addLeaderboardEntry(entry);
  }
}
