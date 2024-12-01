// auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Infrastructure/models/user_model.dart';

part 'auth_state.dart';
part 'auth_event.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      print('SignupEvent triggered: ${event.email}');
      emit(Loading());
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await userCredential.user?.updateDisplayName(event.name);
        final user = userCredential.user;
        if (user != null) {
          print('User authenticated: ${user.email}');
          emit(Authenticated(UserModel(id: user.uid, email: user.email!)));
          await _firestore.collection('users').doc(user.uid).set({
            'name': event.name,
            'email': event.email,
            'uid': user.uid,
          });

        } else {
          print('User is null');
          emit(Unauthenticated());
        }
      } catch (e) {
        print('Error during signup: $e');
        emit(AuthenticateError(e.toString()));
        emit(Unauthenticated());
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(Loading());
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        final user = userCredential.user;
        if (user != null) {
          emit(Authenticated(UserModel(id: user.uid, email: user.email!)));
        } else {
          emit(Unauthenticated());
        }
      } catch (e) {
        emit(AuthenticateError(e.toString()));
        emit(Unauthenticated());
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        await _auth.signOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthenticateError(e.toString()));
      }
    });

  }
}
