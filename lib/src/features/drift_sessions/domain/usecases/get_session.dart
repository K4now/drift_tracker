import '../../../../core/error/failures.dart';
import 'package:drift_tracker/src/core/usecases/usecase.dart';

import '../entities/session.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';


class GetSessionsUseCase implements UseCase<List<Session>, String> {
  final SessionRepository repository;

  GetSessionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Session>>> call(String userId) async {
    return await repository.getSessions(userId);
  }
}
