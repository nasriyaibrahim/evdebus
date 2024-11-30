import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/transport_bloc/tab_event.dart';
import 'package:login/transport_bloc/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabBus()) {
    on<TabTapped>((event, emit) {
      if (event.index == 0) {
        emit(TabBus());
      } else if (event.index == 1) {
        emit(TabTrain());
      }
    });
  }
}
