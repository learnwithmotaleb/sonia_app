import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sonia_app/app/presentation/views/signup_screen.dart';
import 'package:sonia_app/app/presentation/views/terms_screen.dart';

import '../../app_permission/app_permissions.dart';
import '../../core/constants/app_colors.dart';
import 'buttom_navigation.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  final String? password;

  // Constructor with optional email and password parameters
  const LoginScreen({Key? key, this.email, this.password}) : super(key: key);



  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isChecked = false;
  bool obsurcube = true;

  final _formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text = widget.email ?? "";
    passwordController.text = widget.password ?? "";

  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus(); // Hide keyboard
      if (isChecked) {
        Get.to(HomePage()); // Navigate to Home Page
      } else {
        Get.snackbar("Error", "Please accept Terms & Conditions",
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Email Field
                TextFormField(
                  controller: emailController,
                  focusNode: emailFocus,
                  validator: (value) => value!.isEmpty ? "Enter email" : null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(passwordFocus),
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    label: Text("Email"),
                    contentPadding: EdgeInsets.all(12),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  obscureText: obsurcube,
                  validator: (value) => value!.isEmpty ? "Enter Password" : null,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _submitForm, // Pressing "Done" will submit
                  decoration: InputDecoration(
                    hintText: "*******",
                    label: Text("Password"),
                    contentPadding: EdgeInsets.all(12),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => obsurcube = !obsurcube),
                      icon: Icon(
                          obsurcube ? Icons.visibility : Icons.visibility_off),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Terms & Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primary,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(
                            TermsScreen()), // Navigate to Terms & Conditions
                        child: Text(
                          "I agree to the Terms & Conditions",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                             ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Continue Button with Focus Handling
                GestureDetector(
                  onTap: _submitForm,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isChecked ? AppColors.primary : AppColors.grey,
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Does not have account?',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[

                        TextSpan(text: ' Signup', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap=(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));

                              }
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // TODO: Implement Google Login
                              },
                              child: ClipRRect(
                                child: Image.asset("assets/icon/facebook.png",
                                    width: 40, height: 40),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                // TODO: Implement Facebook Login
                              },
                              child: ClipRRect(
                                child: Image.asset("assets/icon/google.png",
                                    width: 40, height: 40),
                              ),
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

