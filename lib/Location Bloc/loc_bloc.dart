import 'package:flutter_bloc/flutter_bloc.dart';

import 'loc_event.dart';
import 'loc_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState(from: '', destination: '')) {
    on<SwapLocations>((event, emit) {
      print('SwapLocations event triggered');
      final newState = state.copyWith(
        from: state.destination,
        destination: state.from,
      );
      emit(newState);
      print('New state: ${newState.from}, ${newState.destination}');
    });

    on<UpdateLocations>((event, emit) {
      final newState = state.copyWith(
        from: event.from,
        destination: event.destination,
      );
      emit(newState);
    });
  }
}
