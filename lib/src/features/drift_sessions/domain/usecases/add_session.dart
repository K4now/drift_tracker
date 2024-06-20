import 'package:drift_tracker/src/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/session.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';


class AddSessionUseCase implements UseCase<void, Session> {
  final SessionRepository repository;

  AddSessionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Session session) async {
    return await repository.addSession(session);
  }
}
