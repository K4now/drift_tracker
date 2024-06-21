import '../../../drift_sessions/domain/entities/session.dart';

abstract class SessionRepositoryOnMensure {
  Future<void> saveSession(Session session);
}
