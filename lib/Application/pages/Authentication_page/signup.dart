import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Loading) {
          // Optional: Show a loading indicator if needed
        } else if (state is Authenticated) {
          // Navigate to Login Page after successful signup
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: BlocProvider.of<AuthBloc>(context),
                child: const LoginPage(),
              ),
            ),
          );
        } else if (state is AuthenticateError) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/register.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 140,
                  ),
                  Text(
                    'SignUp!',
                    style: TextStyle(color: Colors.blue, fontSize: 23),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value != null && value.isEmpty
                          ? 'Enter your name'
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value != null && value.isEmpty
                          ? 'Enter a valid email'
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value != null && value.isEmpty
                          ? 'Enter your password'
                          : null,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Dispatching SignupEvent');
                        authBloc.add(SignupEvent(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ));
                      }
                    },
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
