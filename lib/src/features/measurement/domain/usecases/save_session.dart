import '../../../drift_sessions/domain/entities/session.dart';


import 'package:drift_tracker/src/features/measurement/domain/repositories/session_repositories.dart';

class SaveSessionUseCase {
  final SessionRepositoryOnMensure repository;

  SaveSessionUseCase(this.repository);

  Future<void> call(Session session) async {
    await repository.saveSession(session);
  }
}
