import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:drift_tracker/src/core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUpWithEmail(params.email, params.password);
  }
}

class SignUpParams {
  final String email;
  final String password;

  SignUpParams({required this.email, required this.password});
}
