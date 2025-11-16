// screens/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../app/presentation/views/navigationBarScreen/home_screen.dart';
import 'home_page_phone_number.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  OtpScreen({required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";

  void verifyOtp(String otpCode) {
    if (otpCode.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Empty Code"),
          content: Text("Please enter the OTP code."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return; // Stop here if empty
    }

    // Normally use FirebaseAuth to verify OTP here...

    // For demo, navigate to HomeScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePagePhoneNumber()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verify your Phone number",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),),
            SizedBox(height: 30,),
            Text("Enter your OTP code sent to ${widget.phoneNumber}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              length: 6,
              onChanged: (value) => otp = value,
              onCompleted: (value) => otp = value,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.green,
                selectedFillColor: Colors.green.shade200,
                inactiveFillColor: Colors.grey.shade100,
                activeColor: Colors.green,
                selectedColor: Colors.green,
                inactiveColor: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text("Didn't you receive any code?", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            InkWell(
              onTap: (){},
              child: Text("RESEND NEW CODE",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                color: Colors.red
              ),),
            ),

            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Optional if you want outer container rounded
              ),
              child: ElevatedButton(
                onPressed: () {
                  verifyOtp(otp); // Now checks what the user typed
                },
                child: Text(
                  "VERIFY",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
