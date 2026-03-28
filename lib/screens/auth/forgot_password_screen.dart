import 'package:flutter/material.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:provider/provider.dart';


class ForgotPasswordScreen extends StatefulWidget {
  final String email;
  const ForgotPasswordScreen({super.key, required this.email});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            SizedBox(height: 20),
            Image.asset('assets/images/logo.png', height: 100,),
            SizedBox(height: 30),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              validator: (value){
                if(value== null || value.isEmpty){
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            SizedBox(height: 30),
            Consumer<MyAuthProvider>(
              builder: (context, provider,child) {
                return ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        provider.forgotPassword(email.text);
                      }
                    },
                    child: Text('Reset Password')
                );
              }
            ),

          ],
        ),
      ),
    );
  }
}
