

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/Application/pages/Authentication_page/signup.dart';

import '../../../main.dart';
import '../Main_page/bottom.dart';
import 'bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
       if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  Bottom()),
          );
        } else if (state is AuthenticateError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                height: h,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/login.png'),
                        fit: BoxFit.fill)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                      ),
                      Text('Welcome \n Back !',style: TextStyle(color: Colors.blue,fontSize: 23),),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25,),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your valid Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value != null && value.isEmpty
                              ? 'Enter a valid email'
                              : null,
                        ),
                      ),
                       SizedBox(height: 30),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          maxLines: 1,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) => value != null && value.isEmpty
                              ? 'Enter your password'
                              : null,
                        ),
                      ),
                       SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authBloc.add(LoginEvent(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text('Invalid credentials'),
                              ),
                            );
                          }
                        },
                        child:  Text('Sign In'),
                        style: ElevatedButton.styleFrom(
                          minimumSize:  Size(200, 50),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: authBloc,
                                child: SignupPage(),
                              ),
                            ),
                          );
                        },
                        child:  Text(
                          "Don't have an account? Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
