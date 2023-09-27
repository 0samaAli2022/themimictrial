import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themimictrial/state/auth/providers/auth_state_provider.dart';
import 'package:themimictrial/utils/loading_dialog.dart';
import 'package:themimictrial/views/components/constants/strings.dart';
import 'package:themimictrial/views/constants/app_colors.dart';
import 'package:themimictrial/views1/login/divider_with_margins.dart';
import 'package:themimictrial/views1/login/google_button.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final email = useState('');
    final password = useState('');

    useEffect(
      () {
        emailController.addListener(() {
          email.value = emailController.text;
        });
        return () {};
      },
      [emailController],
    );
    useEffect(
      () {
        passwordController.addListener(() {
          password.value = passwordController.text;
        });
        return () {};
      },
      [passwordController],
    );
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 50, 32, 108),
              Color.fromARGB(255, 101, 53, 113),
            ],
            stops: [
              0.1,
              0.95,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 30, 16.0, 40),
            child: SingleChildScrollView(
              child: Builder(builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "Instagram",
                        style: TextStyle(fontFamily: 'instagram', fontSize: 46),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        "Sign up to see photos and videos of your friends.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.loginButtonTextColor,
                          shape: const CircleBorder()),
                      onPressed: () async {
                        loadingScrean(context, Strings.loading);
                        await ref
                            .read(authStateProvider.notifier)
                            .loginWithGoogle();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: const GoogleButton(),
                    ),
                    const DividerWithMargins(),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 25),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white24.withAlpha(40),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 25),
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white24.withAlpha(40),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        loadingScrean(context, Strings.loading);
                        await ref
                            .read(authStateProvider.notifier)
                            .loginWithEmailAndPassword(
                              emailController.text,
                              passwordController.text,
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white70.withAlpha(15)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your login creds ? ',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text('Get Help Signing In'),
                      ],
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
