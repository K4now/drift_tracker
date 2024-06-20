import '../../../../core/error/failures.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:drift_tracker/src/core/usecases/usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase implements UseCase<User, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    return await repository.signInWithEmail(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
