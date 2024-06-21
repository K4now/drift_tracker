import '../../../drift_sessions/domain/entities/session.dart';
import 'package:drift_tracker/src/features/measurement/domain/repositories/session_repositories.dart';

import '../sources/remote_data_source.dart';

class SessionRepositoryOnMensureImpl implements SessionRepositoryOnMensure {
  final MensureDataSource remoteDataSource;

  SessionRepositoryOnMensureImpl(this.remoteDataSource);

  @override
  Future<void> saveSession(Session session) async {
    await remoteDataSource.saveSession(session);
  }
}
