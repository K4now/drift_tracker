import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:drift_tracker/src/features/leaderboard/data/models/leaderboard_entry.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  final FirebaseFirestore _firestore;

  LeaderboardRepositoryImpl(this._firestore);

  @override
  Stream<List<LeaderboardEntry>> getLeaderboardEntries() {
    return _firestore.collection('leaderboard').orderBy('score', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return LeaderboardEntry.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Future<void> addLeaderboardEntry(LeaderboardEntry entry) async {
    final existingEntry = await _firestore.collection('leaderboard')
      .where('userId', isEqualTo: entry.userId)
      .get();

    if (existingEntry.docs.isEmpty) {
      await _firestore.collection('leaderboard').add(entry.toFirestore());
    } else {
      final currentHighestScore = existingEntry.docs.map((doc) => LeaderboardEntry.fromFirestore(doc)).reduce((a, b) => a.score > b.score ? a : b);
      if (entry.score > currentHighestScore.score) {
        await _firestore.collection('leaderboard').doc(existingEntry.docs.first.id).update(entry.toFirestore());
      }
    }
  }
}