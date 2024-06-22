import 'package:drift_tracker/src/features/leaderboard/data/implements/leaderboard_repository_impl.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_event.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final LeaderboardRepositoryImpl repository;

  LeaderboardBloc(this.repository) : super(LeaderboardLoading()) {
    on<LoadLeaderboard>((event, emit) async {
      emit(LeaderboardLoading());
      try {
        final entriesStream = repository.getLeaderboardEntries();
        await emit.onEach(entriesStream, onData: (entries) {
          emit(LeaderboardLoaded(entries));
        });
      } catch (e) {
        emit(LeaderboardError(e.toString()));
      }
    });
  }
}
