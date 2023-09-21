import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/Login_cubit/states.dart';

import '../../../shared/network/remote/dio_helper.dart';


class SocialLoginCubit extends Cubit<LoginStates>{
  SocialLoginCubit() : super(InitialLoginSocial());

  static SocialLoginCubit get(context)=> BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
       emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }


  IconData suffix= Icons.visibility;
  bool isPassword=true;
  void changePasswordIcons(){
    isPassword=! isPassword;
    suffix= isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(LoginPasswordChangeState());
  }




  }
