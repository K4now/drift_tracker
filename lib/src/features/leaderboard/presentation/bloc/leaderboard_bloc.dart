import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift_tracker/src/features/leaderboard/domain/usecases/get_leaderboard_entries.dart';
import 'package:drift_tracker/src/features/leaderboard/domain/usecases/add_leaderboard_entry.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_event.dart';
import 'package:drift_tracker/src/features/leaderboard/presentation/bloc/leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardEntries getLeaderboardEntries;
  final AddLeaderboardEntry addLeaderboardEntry;

  LeaderboardBloc({
    required this.getLeaderboardEntries,
    required this.addLeaderboardEntry,
  }) : super(LeaderboardLoading()) {
    on<LoadLeaderboard>((event, emit) async {
      emit(LeaderboardLoading());
      try {
        final entriesStream = getLeaderboardEntries();
        await emit.onEach(entriesStream, onData: (entries) {
          emit(LeaderboardLoaded(entries));
        });
      } catch (e) {
        emit(LeaderboardError(e.toString()));
      }
    });

    on<AddLeaderboardEntry>((event, emit) async {
      try {
        await addLeaderboardEntry(event.entry);
        emit(LeaderboardEntryAdded());
        add(LoadLeaderboard()); // Reload the leaderboard after adding a new entry
      } catch (e) {
        emit(LeaderboardError(e.toString()));
      }
    });
  }
}
