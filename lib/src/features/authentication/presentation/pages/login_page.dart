import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drift_tracker/src/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:drift_tracker/routes/app_router.gr.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/drift_logo.png',
                  height: 100,
                ),
                SizedBox(height: 20),
                Text(
                  S.of(context).login,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 20),
                _LoginForm(),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.router.push(RegisterRoute());
                  },
                  child: Text(
                    S.of(context).register,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (user) {
            context.router.replaceAll([const HomeRoute()]);
          },
          error: (message) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Loading) {
            return const CircularProgressIndicator();
          }
          return Column(
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: S.of(context).email,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: S.of(context).password,
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEvent.signInRequested(email, password));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Theme.of(context).primaryColor, // Добавлено для видимости в темной теме
                  foregroundColor: Colors.white, // Добавлено для видимости текста кнопки
                ),
                child: Text(S.of(context).login),
              ),
            ],
          );
        },
      ),
    );
  }
}
