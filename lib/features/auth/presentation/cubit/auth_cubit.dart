import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_app_clean_architecture/features/auth/domain/entities/user_entity.dart';
import 'package:news_app_clean_architecture/features/auth/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isPasswordVisible = false;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(AuthPasswordVisibility(isPasswordVisible));
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    return null;
  }

  Future<void> signIn() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      emit(AuthFailure("Fields can't be empty"));
      return;
    }

    emailFocus.unfocus();
    passwordFocus.unfocus();
    emit(AuthLoading());

    try {
      final user =
          await authRepository.signInWithEmailAndPassword(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final username = usernameController.text;
    final phone = phoneController.text;

    emailFocus.unfocus();
    passwordFocus.unfocus();
    nameFocus.unfocus();
    usernameFocus.unfocus();
    phoneFocus.unfocus();
    emit(AuthLoading());

    try {
      final UserEntity userEntity = UserEntity(
        email: email,
        fullname: name,
        username: username,
        phone: phone,
      );
      final user = await authRepository.signUpWithEmailAndPassword(
        userEntity,
        password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> checkSignInStatus() async {
    emit(AuthLoading());
    try {
      final isSignedIn = await authRepository.isSignedIn();
      if (isSignedIn) {
        final user = await authRepository.getUser();
        emit(AuthSuccess(user));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(AuthSignedOut());
  }

  Future<UserEntity> getSignedInUser() async {
    emit(AuthLoading());
    try {
      final user = await authRepository.getUser();
      emit(AuthSuccess(user));
      return user;
    } catch (e) {
      emit(AuthFailure(e.toString()));
      // Propagate the error to the FutureBuilder.
      throw Exception(e);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    nameFocus.dispose();
    usernameFocus.dispose();
    phoneFocus.dispose();
    return super.close();
  }
}
