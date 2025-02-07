import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Navigate to home screen using a named route.
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          // Obtain the AuthCubit instance from the context.
          final authCubit = context.read<AuthCubit>();

          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Form(
                key: authCubit.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please fill in the details to continue",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      // Full Name Field
                      CustomTextField(
                        controller: authCubit.nameController,
                        focusNode: authCubit.nameFocus,
                        hintText: "Full Name",
                        validator: authCubit.validateName,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      const SizedBox(height: 16),
                      // Username Field
                      CustomTextField(
                        controller: authCubit.usernameController,
                        focusNode: authCubit.usernameFocus,
                        hintText: "Username",
                        validator: authCubit.validateUsername,
                        prefixIcon: const Icon(Icons.alternate_email),
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      CustomTextField(
                        controller: authCubit.emailController,
                        focusNode: authCubit.emailFocus,
                        hintText: "Email",
                        validator: authCubit.validateEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: 16),
                      // Phone Number Field
                      CustomTextField(
                        controller: authCubit.phoneController,
                        focusNode: authCubit.phoneFocus,
                        hintText: "Phone Number",
                        validator: authCubit.validatePhone,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      CustomTextField(
                        controller: authCubit.passwordController,
                        focusNode: authCubit.passwordFocus,
                        validator: authCubit.validatePassword,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        obscureText: !authCubit.isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: authCubit.togglePasswordVisibility,
                          icon: Icon(
                            authCubit.isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        onPressed: () {
                          // Validate the form before calling signIn.
                          if (authCubit.formKey.currentState?.validate() ??
                              false) {
                            authCubit.signUp();
                          }
                        },
                        text: "Create Account",
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 20),
                      // Login link using a Row with a TextButton.
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
