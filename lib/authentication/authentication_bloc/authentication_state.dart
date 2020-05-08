part of 'authentication_bloc.dart';

//clase pricipal
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}
//estados necesarios para el login 

//si esta 
class AuthenticateInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedSuccessfully extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  @override
  List<Object> get props => [];
}
