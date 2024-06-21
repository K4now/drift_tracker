
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:meta/meta.dart';
  
  part 'measurement_event.dart';
  part 'measurement_state.dart';
  
  class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
    MeasurementBloc() : super(MeasurementInitial()) {
      on<MeasurementEvent>((event, emit) {
        // TODO: implement event handler
      });
    }
  }
