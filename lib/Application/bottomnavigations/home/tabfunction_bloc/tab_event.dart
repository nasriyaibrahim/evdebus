import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TabTapped extends TabEvent {
  final int index;

  TabTapped({required this.index});

  @override
  List<Object> get props => [index];
}
