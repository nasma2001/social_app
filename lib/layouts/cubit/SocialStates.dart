
abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}
class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates{
  String? error;
  SocialGetUserErrorState(error);
}

class SocialChangeBtmNavBar extends SocialStates{}

class SocialAddPostState extends SocialStates{}

class SocialSuccessGetProfileImageState extends SocialStates{}
class SocialErrorGetProfileImageState extends SocialStates{}

class SocialSuccessGetCoverImageState extends SocialStates{}
class SocialErrorGetCoverImageState extends SocialStates{}

class SocialSuccessUploadProfileImageState extends SocialStates{}
class SocialErrorUploadProfileImageState extends SocialStates{
  String? error;
  SocialErrorUploadProfileImageState(error);
}
class SocialLoadingUploadProfileImageState extends SocialStates{}

class SocialSuccessUploadCoverState extends SocialStates{}
class SocialErrorUploadCoverState extends SocialStates{
  String? error;
  SocialErrorUploadCoverState(error);
}
class SocialLoadingUploadCoverState extends SocialStates{}

class SocialErrorUpdateUserState extends SocialStates{
  String? error;
  SocialErrorUpdateUserState(error);
}
class SocialLoadingUpdateUserState extends SocialStates{}
class SocialSuccessUpdateUserState extends SocialStates{}

class SocialSuccessGetPostImageState extends SocialStates{}
class SocialErrorGetPostImageState extends SocialStates{}

class SocialSuccessUploadPostImageState extends SocialStates{}
class SocialErrorUploadPostImageState extends SocialStates{
  String? error;
  SocialErrorUploadPostImageState(error);
}
class SocialLoadingUploadPostImageState extends SocialStates{}

class SocialLoadingCreatePostState extends SocialStates{}
class SocialSuccessCreatePostState extends SocialStates{}

class SocialErrorCreatePostState extends SocialStates{
  String? error;
  SocialErrorCreatePostState(error);
}

class SocialRemovePostImageState extends SocialStates{}


class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  String? error;
  SocialGetPostsErrorState(error);
}

class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{
  String? error;
  SocialLikePostErrorState(error);
}

class SocialAddCommentSuccessState extends SocialStates{}
class SocialAddCommentErrorState extends SocialStates{
  String? error;
  SocialAddCommentErrorState(error);
}

class SocialGetUsersSuccessState extends SocialStates{}
class SocialGetUsersLoadingState extends SocialStates{}
class SocialGetUsersErrorState extends SocialStates{
  String? error;
  SocialGetUsersErrorState(error);
}

class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  String? error;
  SocialSendMessageErrorState(error);
}
class SocialGetMessageSuccessState extends SocialStates{}














