import '../../../../core/error/failures.dart';
import '../entities/session.dart';
import 'package:dartz/dartz.dart';

abstract class SessionRepository {
  Future<Either<Failure, void>> addSession(Session session);
  Future<Either<Failure, List<Session>>> getSessions(String userId);
  Future<Either<Failure, void>> deleteSession(String sessionId); // Add this line
}