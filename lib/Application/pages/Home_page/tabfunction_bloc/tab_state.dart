import 'package:equatable/equatable.dart';

abstract class TabState extends Equatable {
  @override
  List<Object> get props => [];
}

class TabBus extends TabState {}

class TabTrain extends TabState {}
