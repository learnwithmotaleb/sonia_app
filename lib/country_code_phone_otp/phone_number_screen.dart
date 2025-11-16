// screens/phone_screen.dart
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'opt_screen.dart';

class PhoneScreen extends StatefulWidget {
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  String fullPhoneNumber = '';

  void onNext() {
    if (fullPhoneNumber.isNotEmpty) {
      if (fullPhoneNumber.startsWith('+8800')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Invalid Number"),
            content: Text("Please enter the phone number without the leading 0."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
        return; // Stop navigation
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(phoneNumber: fullPhoneNumber),
        ),
      );
    } else {
      // Optional: Alert if empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Empty Number"),
          content: Text("Please enter your phone number."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Sign up to keep ordering home-made SONIA.",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),),
              SizedBox(height: 30,),
              Text("Add your phone number. We'll send you a verification code so w know you're real."),
              SizedBox(height: 30,),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10)

                  ),
                ),
                initialCountryCode: 'BD', // Default country code
                onChanged: (phone) {
                  fullPhoneNumber = phone.completeNumber;
                },
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Optional if you want outer container rounded
                ),
                child: ElevatedButton(
                  onPressed: onNext,
                  child: Text("SEND OTP",style: TextStyle(
                    color: Colors.white
                  ),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // 👈 Rounded corners for the button
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
