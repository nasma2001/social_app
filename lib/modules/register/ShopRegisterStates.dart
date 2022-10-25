

import '../../models/LoginModel.dart';

abstract class SocialRegisterStates{}

class SocialInitialRegisterState extends SocialRegisterStates{}

class SocialSuccessRegisterState extends SocialRegisterStates{
  final LoginModel? model;
  SocialSuccessRegisterState({
    required this.model
});
}

class SocialErrorRegisterState extends SocialRegisterStates{
  final String error;
  SocialErrorRegisterState({
    required this.error
  });
}

class SocialLoadingCreateUserState extends SocialRegisterStates{}

class SocialSuccessCreateUserState extends SocialRegisterStates{
  late final LoginModel model;
  SocialSuccessCreateUserState({
    required this.model
  });
}

class SocialErrorCreateUserState extends SocialRegisterStates{
  final String error;
  SocialErrorCreateUserState({
    required this.error
  });
}

class SocialLoadingRegisterState extends SocialRegisterStates{}

class SocialRegisterPasswordChangeVisibility extends SocialRegisterStates{}