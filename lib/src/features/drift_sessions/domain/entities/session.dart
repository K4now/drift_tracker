import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
  final String id;
  final String userId;
  final double maxAngle;
  final int points;
  final double averageSpeed;
  final Timestamp timestamp;

  Session({
    required this.id,
    required this.userId,
    required this.maxAngle,
    required this.points,
    required this.averageSpeed,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'maxAngle': maxAngle,
      'points': points,
      'averageSpeed': averageSpeed,
      'timestamp': timestamp,
    };
  }
   Session copyWith({
    String? id,
    String? userId,
    double? maxAngle,
    int? points,
    double? averageSpeed,
    Timestamp? timestamp,
  }) {
    return Session(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      maxAngle: maxAngle ?? this.maxAngle,
      points: points ?? this.points,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'],
      userId: map['userId'],
      maxAngle: map['maxAngle'],
      points: map['points'],
      averageSpeed: map['averageSpeed'],
      timestamp: map['timestamp'],
    );
  }
}
