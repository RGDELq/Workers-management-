import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workers_managment_app/utils/theme.dart';
import 'package:workers_managment_app/screens/widgets/primary_btn.dart';
import 'package:workers_managment_app/screens/widgets/textfield.dart';
import 'package:workers_managment_app/screens/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool enableResetBtn = false;
  bool isLoading = false;

  GlobalKey<FormState> resetFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 224, 224, 217),
              primary,
            ],
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
                SizedBox(height: size.height * 0.05),
                
                // Back button
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),

                // Logo
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                  height: 150,
                ),

                const SizedBox(height: 20),

                // Title
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle
                Text(
                  "Enter your email address and we'll send you a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 40),

                // Form
                Form(
                  key: resetFormKey,
                  onChanged: () {
                    setState(() {
                      enableResetBtn = resetFormKey.currentState!.validate();
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
                      
                      SizedBox(height: size.height * 0.05),
                      
                      Primarybtn(
                        text: "Send Reset Link",
                        withBorder: false,
                        isloading: isLoading,
                        isActive: enableResetBtn,
                        onPressed: () async {
                          String email = emailController.text.trim();

                          if (email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter your email address',
                                ),
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          // Simulate sending reset email
                          await Future.delayed(const Duration(seconds: 2));

                          setState(() {
                            isLoading = false;
                          });

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Password reset link sent to $email',
                              ),
                              backgroundColor: primary,
                            ),
                          );

                          // Navigate back to login screen
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const LoginScreenn(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Back to login link
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "Remember your password? ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
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
  }
} 