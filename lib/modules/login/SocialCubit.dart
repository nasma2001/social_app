import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/SocialStates.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../models/LoginModel.dart';
import '../../shared/network/local/CacheHelper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitialLoginState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin(
      {
        required String email,
        required String password,
        required BuildContext context}
      ) {
      emit(SocialLoadingLoginState());
      FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password
      )
        .then((value) {
      emit(SocialSuccessLoginState(value.user!.uid));

    }).catchError((error) {
      emit(SocialErrorLoginState(error.toString()));
    });
  }

  IconData passwordVisibilityIcon = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    passwordVisibilityIcon =
        isPassword ? Icons.visibility : Icons.visibility_off;
    emit(SocialPasswordChangeVisibility());
  }
}
