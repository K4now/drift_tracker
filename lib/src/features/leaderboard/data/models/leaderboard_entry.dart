import 'package:cloud_firestore/cloud_firestore.dart';


class LeaderboardEntry {
  final String userId;
  final String carModel;
  final int score;
  final DateTime date;

  LeaderboardEntry({
    required this.userId,
    required this.carModel,
    required this.score,
    required this.date,
  });

  factory LeaderboardEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LeaderboardEntry(
      userId: data['userId'] ?? '',
      carModel: data['carModel'] ?? '',
      score: data['score'] ?? 0,
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'carModel': carModel,
      'score': score,
      'date': date,
    };
  }
}
