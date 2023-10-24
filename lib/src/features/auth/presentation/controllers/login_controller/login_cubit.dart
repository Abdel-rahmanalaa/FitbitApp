import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitbit/src/core/usecases/base_usecase.dart';
import 'package:fitbit/src/features/auth/domain/usecases/sign_in_with_email_password_usecase.dart';
import 'package:fitbit/src/features/auth/domain/usecases/sign_in_with_facebook_usecase.dart';
import 'package:fitbit/src/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:fitbit/src/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

abstract class LoginStrategy {
  void login();
}

class LoginCubit extends Cubit<LoginState> {
  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SignOutUseCase _signOutUseCase;

  LoginCubit(
    this._signInWithEmailAndPasswordUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithFacebookUseCase,
    this._signOutUseCase,
  ) : super(LoginInitial());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final response = await _signInWithEmailAndPasswordUseCase(
        SignInParameters(email: email, password: password));

    response.fold(
      (l) => emit(SignInError(error: l.message)),
      (r) => emit(SignInSuccess()),
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final response = await _signInWithGoogleUseCase(const NoParameters());

    response.fold(
      (l) => emit(SignInError(error: l.message)),
      (r) => emit(SignInSuccess()),
    );
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final response = await _signInWithFacebookUseCase(const NoParameters());

    response.fold(
      (l) => emit(SignInError(error: l.message)),
      (r) => emit(SignInSuccess()),
    );
  }

  Future<void> signOut() async {
    final response = await _signOutUseCase(const NoParameters());

    response.fold(
      (l) => emit(SignOutError(error: l.message)),
      (r) => emit(SignOutSuccess()),
    );
  }
}