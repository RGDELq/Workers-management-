import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/main_bottom_navigation.dart';
import 'package:workers_managment_app/screens/reset_password_screen.dart';
import 'package:workers_managment_app/screens/home_screen.dart';

class LoginScreenn extends StatefulWidget {
  const LoginScreenn({super.key});

  @override
  State<LoginScreenn> createState() => _LoginScreennState();
}

class _LoginScreennState extends State<LoginScreenn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool enableLoginBtn = false;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 224, 224, 217), primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                  height: 150,
                ),

                const SizedBox(height: 20),

                // Centered "Sign In"
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 30),

                // Form
                Form(
                  key: loginFormKey,
                  onChanged: () {
                    setState(() {
                      enableLoginBtn = loginFormKey.currentState!.validate();
                    });
                  },
                  child: Column(
                    children: [
                      TextFieldWidget(
                        filled: true,
                        label: 'Email address',
                        controller: emailController,
                        hintText: 'ex: a@example.com',
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your email address";
                          }
                          if (!value.contains('@') || !value.contains('.com')) {
                            return "Enter a Valid Email";
                          }
                          return null;
                        },
                        fillColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        obSecureText: true,
                        filled: true,
                        fillColor: Colors.white,
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: passwordController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Please enter your Password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder:
                                      ((context) =>
                                          const ResetPasswordScreen()),
                                ),
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.05),
                      Primarybtn(
                        text: "Log in",
                        withBorder: false,
                        isloading: false,
                        isActive: enableLoginBtn,
                        onPressed: () async {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter your email and password',
                                ),
                              ),
                            );
                            return;
                          }

                          // Optionally: Authenticate the user here

                          // Navigate to home (DashboardScreen)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        },
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
  }
}
