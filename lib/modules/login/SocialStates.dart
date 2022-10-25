
import 'package:social_app/models/LoginModel.dart';

abstract class SocialLoginStates{}

class SocialInitialLoginState extends SocialLoginStates{}

class SocialSuccessLoginState extends SocialLoginStates{
  String uId;
  SocialSuccessLoginState(this.uId);
}

class SocialErrorLoginState extends SocialLoginStates{
  String? error;
  SocialErrorLoginState(this.error);
}

class SocialLoadingLoginState extends SocialLoginStates{}

class SocialPasswordChangeVisibility extends SocialLoginStates{}