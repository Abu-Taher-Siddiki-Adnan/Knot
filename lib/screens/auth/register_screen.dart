import 'package:flutter/material.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:knot/utils/route_helper.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
              controller: name,
              decoration: InputDecoration(
                  hintText: 'Name'
              ),
              validator: (value){
                if(value== null || value.isEmpty){
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
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
                  return provider.loading? Center(child: CircularProgressIndicator()):
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          provider.register(name.text, email.text, password.text);
                        }
                      },
                      child: Text('Register')
                  );
                }
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, RouteHelper.login);
                    },
                    child: Text('Login Now')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
