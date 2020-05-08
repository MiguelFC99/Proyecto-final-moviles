import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';


part 'acerca_event.dart';
part 'acerca_state.dart';

class AcercaBloc extends Bloc<AcercaEvent, AcercaState> {
  @override
  AcercaState get initialState => AcercaInitial();

  @override
  Stream<AcercaState> mapEventToState(
    AcercaEvent event,
  ) async* {
    if(event is EviarEvent){
      await _email();
      yield  AcercaInitial();

    }
    // TODO: implement mapEventToState
  }

  _email() async {
  final Email email = Email(
    body: 'Email body',
    recipients: ['is715460@iteso.mx'],
    subject: 'Proyecto Moviles',
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
  }
}
