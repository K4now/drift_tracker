import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/domain/usecases/get_car_data.dart';
import 'package:drift_tracker/src/features/profile/domain/usecases/save_car_data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetCarData getCarData;
  final SaveCarData saveCarData;

  ProfileBloc({required this.getCarData, required this.saveCarData}) : super(ProfileInitial()) {
    on<LoadCarData>(_onLoadCarData);
    on<SaveCarDataEvent>(_onSaveCarData);
  }

  void _onLoadCarData(LoadCarData event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final car = await getCarData(event.userId);
      if (car != null) {
        emit(ProfileLoaded(car));
      } else {
        emit(ProfileNoData());
      }
    } catch (e) {
      emit(ProfileError('Failed to load car data'));
    }
  }

  void _onSaveCarData(SaveCarDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await saveCarData(event.userId, event.car);
      emit(ProfileSaved());
    } catch (e) {
      emit(ProfileError('Failed to save car data'));
    }
  }
}
