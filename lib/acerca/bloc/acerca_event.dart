part of 'acerca_bloc.dart';

abstract class AcercaEvent extends Equatable {
  const AcercaEvent();
}

class EviarEvent extends AcercaEvent {
  @override
  List<Object> get props => [];
}
