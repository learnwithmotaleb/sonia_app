// Terms & Conditions Page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppTermsAndContion,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(EffectiveDate),
              SizedBox(height: 10,),
              Text(Welcome),
              SizedBox(height: 10,),
              Text(AcceptanceOfTerms,style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(AcceptanceOfTerms_message),
              SizedBox(height: 10,),
              Text(useApp,style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5,),
              Text(useAppMessage),
            ],
          ),
        ),
      ),
    );
  }
}