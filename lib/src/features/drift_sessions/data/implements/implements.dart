
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/core/error/failures.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/repositories/repositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionRepositoryImpl implements SessionRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  SessionRepositoryImpl({required this.firestore, required this.auth});

  @override
  Future<Either<Failure, void>> addSession(Session session) async {
    try {
      final userId = auth.currentUser?.uid;
      if (userId == null) {
        return Left(ServerFailure());
      }
      final sessionWithUserId = session.copyWith(userId: userId);
      await firestore.collection('sessions').doc(session.id).set(sessionWithUserId.toMap());
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Session>>> getSessions(String userId) async {
    try {
      final querySnapshot = await firestore.collection('sessions').where('userId', isEqualTo: userId).get();
      final sessions = querySnapshot.docs.map((doc) => Session.fromMap(doc.data())).toList();
      return Right(sessions);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteSession(String sessionId) async {
    try {
      await firestore.collection('sessions').doc(sessionId).delete();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}