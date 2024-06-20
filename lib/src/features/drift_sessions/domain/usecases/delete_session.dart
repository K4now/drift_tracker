import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:drift_tracker/src/core/error/failures.dart';

class DeleteSessionUseCase {
  final SessionRepository repository;

  DeleteSessionUseCase(this.repository);

  Future<Either<Failure, void>> call(String sessionId) async {
    return await repository.deleteSession(sessionId);
  }
}
