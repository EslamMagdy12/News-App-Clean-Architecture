import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:news_app_clean_architecture/core/di/di.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Create a new AuthCubit instance using getIt.
      create: (context) => getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Navigate to home screen upon successful authentication.
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
          // Retrieve the AuthCubit from the context.
          final authCubit = context.read<AuthCubit>();

          return Scaffold(
            body: SafeArea(
              child: Form(
                key: authCubit.formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        "Welcome Back",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Sign in to continue",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      // Email Text Field
                      CustomTextField(
                        controller: authCubit.emailController,
                        hintText: "Email",
                        focusNode: authCubit.emailFocus,
                        validator: authCubit.validateEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(height: 16),
                      // Password Text Field
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
                      // Login Button
                      CustomButton(
                        onPressed: () {
                          // Validate the form before calling signIn.
                          if (authCubit.formKey.currentState?.validate() ??
                              false) {
                            authCubit.signIn();
                          }
                        },
                        text: 'Login',
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                      const SizedBox(height: 20),
                      // Sign Up Link using Row and TextButton.
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Sign up",
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
