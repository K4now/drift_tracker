import '../../data/models/leaderboard_entry.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboardEntries {
  final LeaderboardRepository repository;

  GetLeaderboardEntries(this.repository);

  Stream<List<LeaderboardEntry>> call() {
    return repository.getLeaderboardEntries();
  }
}
