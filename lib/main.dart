import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Application/pages/Authentication_page/bloc/auth_bloc.dart';
import 'Application/pages/Authentication_page/login.dart';
import 'Application/pages/Authentication_page/signup.dart';
import 'Application/pages/Home_page/tabfunction_bloc/tab_bloc.dart';
import 'Application/pages/Main_page/bottom.dart';
import 'Application/widgets/evde bus/evdebuswidgets/Location Bloc/loc_bloc.dart';
import 'firebase_options.dart';
var h;
var w;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<TabBloc>(
          create: (context) => TabBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.sizeOf(context).height;
    w = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const Bottom(),
      },
    );
  }
}
