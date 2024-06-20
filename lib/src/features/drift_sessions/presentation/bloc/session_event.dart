part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class AddSessionEvent extends SessionEvent {
  final Session session;

  const AddSessionEvent(this.session);

  @override
  List<Object> get props => [session];
}

class GetSessionsEvent extends SessionEvent {
  final String userId;

  const GetSessionsEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteSessionEvent extends SessionEvent {
  final String sessionId;

  const DeleteSessionEvent(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
