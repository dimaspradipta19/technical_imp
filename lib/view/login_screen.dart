import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:technical_imp/viewmodel/provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              /* Using FormBuilder */
              // FormBuilder(
              //   key: _formKey,
              //   child: Column(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(border: Border.all()),
              //         child: FormBuilderTextField(
              //           name: "Email",
              //           controller: _emailController,
              //           decoration: const InputDecoration(
              //               hintText: "Masukkan email",
              //               border: InputBorder.none),
              //         ),
              //       ),
              //       const SizedBox(height: 20),
              //       Container(
              //         decoration: BoxDecoration(border: Border.all()),
              //         child: FormBuilderTextField(
              //           name: "Password",
              //           controller: _passwordController,
              //           decoration: const InputDecoration(
              //               hintText: "Masukkan password",
              //               border: InputBorder.none),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder(), hintText: "Email"),
                      validator: (valueEmail) {
                        if (valueEmail == null || valueEmail.isEmpty) {
                          return 'Please enter some text';
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(valueEmail)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder(), hintText: "Password"),
                      validator: (valuePassword) {
                        if (valuePassword == null || valuePassword.isEmpty) {
                          return 'Please enter your password';
                        } else if (valuePassword.length < 8) {
                          return "Password must be 8 character";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<AuthProvider>(context, listen: false).postLogin(
                        _emailController.text,
                        _passwordController.text,
                        context);
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
