import 'package:chat_messanger_app/components/my_button.dart';
import 'package:chat_messanger_app/components/my_text_field.dart';
import 'package:chat_messanger_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  // text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not Match"),),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text,);

      if (!mounted) return;

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // logo
                Icon(
                  Icons.message,
                  size: 100,
                ),

                const SizedBox(height: 50),
            
                // welcome back message
                Text(
                  "Let's create an account for you!",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 50),
            
                // email textfield
                MyTextField(
                  controller: emailController,
                   hintText: 'Email', 
                   obscureText: false
                  ),

                  const SizedBox(height: 50),

                // password textfield
                MyTextField(
                  controller: passwordController,
                   hintText: 'Password', 
                   obscureText: true,
                  ),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                   hintText: 'Confirm Password', 
                   obscureText: true,
                  ),

                  const SizedBox(height: 50),
            
                // sign up button
                MyButton(onTap: signUp, text: "Sign In",),

                const SizedBox(height: 50),
            
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}