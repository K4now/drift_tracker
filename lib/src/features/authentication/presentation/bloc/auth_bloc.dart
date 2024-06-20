import '../../domain/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState.initial()) {
    on<SignInRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await authRepository.signInWithEmail(event.email, event.password);
      result.fold(
        (failure) => emit(AuthState.error(failure.toString())),
        (user) => emit(AuthState.authenticated(user)),
      );
    });

    on<SignUpRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await authRepository.signUpWithEmail(event.email, event.password);
      result.fold(
        (failure) => emit(AuthState.error(failure.toString())),
        (user) => emit(AuthState.authenticated(user)),
      );
    });

    on<SignOutRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await authRepository.signOut();
      result.fold(
        (failure) => emit(AuthState.error(failure.toString())),
        (_) => emit(const AuthState.unauthenticated()),
      );
    });
  }
}
