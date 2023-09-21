import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

import '../../../shared/network/remote/dio_helper.dart';


class SocialRegisterCubit extends Cubit<RegisterStates> {
  SocialRegisterCubit() : super(InitialRegisterSocial());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordIcons() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(RegisterPasswordChangeState());
  }



  void userRegister({
    required String? name,
    required String? email,
    required String? password,
    required String? phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      userCreate(
        uId: value.user!.uid,
        phone: phone!,
        email: email,
        name: name!,

      );
      print(value.user!.email);
      print(value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }

  //to create user database
void userCreate({
  required String name,
  required String email,
  required String phone,
  required String uId,
}){
  SocialUserModel model = SocialUserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    image: 'https://img.freepik.com/free-photo/analog-portrait-beautiful-woman-posing-artistically-indoors_23-2149630182.jpg?w=1060&t=st=1693827229~exp=1693827829~hmac=88b2932a6c9c527fa6b32e71c136d7815038457bd1567bdf6415798a29c6c16e',
    cover:'https://img.freepik.com/free-photo/close-up-male-hands-using-tablet-with-blank-screen_155003-37639.jpg?w=1060&t=st=1693757666~exp=1693758266~hmac=706c68af619bb1a073dc60a1410727fd342493dbf4205c593ad9f53285c4175f',
    bio:'write your bio .....',
    isEmailVerified: false,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap())
      .then((value)
  {
    emit(SocialCreateUserSuccessState());
  })
      .catchError((error) {
    print(error.toString());
    emit(SocialCreateUserErrorState(error.toString()));
  });
}

}