
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/constants.dart';
import '../../models/LoginModel.dart';
import 'ShopRegisterStates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{

  SocialRegisterCubit(): super(SocialInitialRegisterState());

  static SocialRegisterCubit get(context)=> BlocProvider.of(context);

  LoginModel? model;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
}){
    emit(SocialLoadingRegisterState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      createUser(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
      uId = value.user!.uid;
    }).catchError((error){
      emit(SocialErrorRegisterState(error: error.toString()));
    });

  }
  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }){
    emit(SocialLoadingCreateUserState());
    LoginModel model = LoginModel(
        email: email,
        uId: uId,
        name: name,
        phone: phone,
        isEmailVerified: false
    );
  FirebaseFirestore.instance.collection('user')
      .doc(uId)
      .set(model.toMap())
      .then((value){
        emit(SocialSuccessCreateUserState(model: model));
      })
      .catchError((error){
        emit(SocialErrorCreateUserState(error: error));
      });
}



  IconData passwordVisibilityIcon=Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
        isPassword = !isPassword;
        passwordVisibilityIcon=isPassword?Icons.visibility:Icons.visibility_off;
        emit(SocialRegisterPasswordChangeVisibility());
  }

}