import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/features/leaderboard/data/models/leaderboard_entry.dart';

class LeaderboardRepositoryImpl {
  final FirebaseFirestore _firestore;

  LeaderboardRepositoryImpl(this._firestore);

  Stream<List<LeaderboardEntry>> getLeaderboardEntries() {
    return _firestore.collection('leaderboard').orderBy('score', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => LeaderboardEntry.fromFirestore(doc)).toList();
    });
  }
}
