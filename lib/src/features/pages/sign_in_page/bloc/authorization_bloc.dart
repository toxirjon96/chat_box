import 'package:bloc/bloc.dart';

import '../data/authorization_repository.dart';

/// Events
sealed class AuthEvent {
  const AuthEvent._();
}

final class Auth$SendSmsCodeEvent extends AuthEvent {
  const Auth$SendSmsCodeEvent(this.phoneNumber) : super._();
  final String phoneNumber;
}

final class Auth$SignInEvent extends AuthEvent {
  const Auth$SignInEvent({
    required this.id,
    required this.smsCode,
  }) : super._();

  final String id;
  final String smsCode;
}

/// States
sealed class AuthState {
  const AuthState._();
}

final class Auth$InitState extends AuthState {
  const Auth$InitState() : super._();
}

final class Auth$LoadingState extends AuthState {
  const Auth$LoadingState() : super._();
}

final class Auth$ErrorState extends AuthState {
  const Auth$ErrorState(this.message) : super._();

  final String message;
}

final class Auth$SuccessState extends AuthState {
  const Auth$SuccessState(this.verificationId) : super._();

  final String verificationId;
}

final class Auth$SignInSuccessState extends AuthState {
  const Auth$SignInSuccessState() : super._();
}

/// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required IAuthorizationRepository repository})
      : _repository = repository,
        super(const Auth$InitState()) {
    on<AuthEvent>(
      (event, emit) => switch (event) {
        Auth$SendSmsCodeEvent event => _sendSmsCode(event, emit),
        Auth$SignInEvent event => _signIn(event, emit),
      },
    );
  }

  final IAuthorizationRepository _repository;

  Future<void> _sendSmsCode(
    Auth$SendSmsCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const Auth$LoadingState());
      final id = await _repository.signInWithPhoneNumber(event.phoneNumber);
      if (id != null) {
        emit(Auth$SuccessState(id));
      } else {
        emit(const Auth$ErrorState('Verification id did not come'));
      }
    } on Object catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      emit(const Auth$ErrorState('Something went wrong!'));
    }
  }

  Future<void> _signIn(
    Auth$SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const Auth$LoadingState());

      await _repository.otpSignIn(
        id: event.id,
        smsCode: event.smsCode,
      );

      emit(const Auth$SignInSuccessState());
    } on Object catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      emit(const Auth$ErrorState('Something went wrong'));
    }
  }
}
