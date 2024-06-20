import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/add_session.dart';
import '../../domain/usecases/delete_session.dart';
import '../../domain/usecases/get_session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AddSessionUseCase addSessionUseCase;
  final GetSessionsUseCase getSessionsUseCase;
  final DeleteSessionUseCase deleteSessionUseCase; // Add this line

  SessionBloc({
    required this.addSessionUseCase,
    required this.getSessionsUseCase,
    required this.deleteSessionUseCase, // Add this line
  }) : super(SessionInitial()) {
    on<AddSessionEvent>((event, emit) async {
      emit(SessionLoading());
      final result = await addSessionUseCase(event.session);
      result.fold(
        (failure) => emit(SessionError('Failed to add session')),
        (_) => emit(SessionAdded()),
      );
    });

    on<GetSessionsEvent>((event, emit) async {
      emit(SessionLoading());
      final result = await getSessionsUseCase(event.userId);
      result.fold(
        (failure) => emit(SessionError('Failed to fetch sessions')),
        (sessions) => emit(SessionLoaded(sessions)),
      );
    });

    on<DeleteSessionEvent>((event, emit) async {
      emit(SessionLoading());
      final result = await deleteSessionUseCase(event.sessionId);
      result.fold(
        (failure) => emit(SessionError('Failed to delete session')),
        (_) => emit(SessionDeleted()),
      );
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        add(GetSessionsEvent(userId));
      }
    });
  }
}
