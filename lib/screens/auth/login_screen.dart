import 'package:flutter/material.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/route_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
            SizedBox(height: 15),
            TextFormField(
                controller: password,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                }
            ),
            SizedBox(height: 30),
            Consumer<MyAuthProvider>(
                builder: (context, provider, child) {
                  return provider.loading? Center(child: CircularProgressIndicator(),):
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          provider.login(email.text, password.text);
                        }
                      },
                      child: Text('Login')
                  );
                }
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RouteHelper.forgotPassword, arguments: email.text);
                    },
                    child: Text('Forgot Password')
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RouteHelper.register);
                    },
                    child: Text('Register Now')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
