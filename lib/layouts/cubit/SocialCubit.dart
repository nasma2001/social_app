
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/models/AddPostModel.dart';
import 'package:social_app/models/ChatModel.dart';
import 'package:social_app/models/LoginModel.dart';
import 'package:social_app/modules/addPost/AddPost.dart';
import 'package:social_app/modules/chats/ChatScreen.dart';
import 'package:social_app/modules/home/HomeScreen.dart';
import 'package:social_app/modules/login/LoginScreen.dart';
import 'package:social_app/modules/settings/SettingsScreen.dart';
import 'package:social_app/modules/users/UsersScreen.dart';
import 'package:social_app/shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/CacheHelper.dart';
import 'SocialStates.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    const ChatScreen(),
    const AddPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings'
  ];

  int currentIndex = 0;

  void changeBtmNavBar(index) {
    if (index == 2) {
      emit(SocialAddPostState());
    }
    else {
      currentIndex = index;
      emit(SocialChangeBtmNavBar());
    }
  }

  LoginModel? model;
  void getUser() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('user')
        .doc(uId)
        .get()
        .then((value) {
      model = LoginModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      emit(SocialGetUserErrorState(error));
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialSuccessGetProfileImageState());
    } else {
      emit(SocialErrorGetProfileImageState());
    }
  }

  File? coverImage;
  Future getCoverImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialSuccessGetCoverImageState());
    } else {
      emit(SocialErrorGetCoverImageState());
    }
  }

  void uploadProfileImage(
      String? name,
      String? bio,
      String? phone) {
    emit(SocialLoadingUploadProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        emit(SocialSuccessUploadProfileImageState());
        updateProfile(
            bio: bio,
            name: name,
            phone: phone,
            profileImage: value
        );
      })
          .catchError((error) {
        emit(SocialErrorUploadProfileImageState(error));
      });
    })
        .catchError((error) {
      emit(SocialErrorUploadProfileImageState(error));
    });
  }

  void uploadCoverImage({
    String? name,
    String? bio,
    String? phone
  }) {
    emit(SocialLoadingUploadCoverState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage!.path)
        .pathSegments
        .last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref
          .getDownloadURL()
          .then((value) {
        emit(SocialSuccessUploadCoverState());
        updateProfile(
          phone: phone ?? model!.phone,
          name: name ?? model!.name,
          bio: bio ?? model!.bio ?? '',
          cover: value,
        );
      })
          .catchError((error) {
        emit(SocialErrorUploadCoverState(error));
      });
    })
        .catchError((error) {
      emit(SocialErrorUploadCoverState(error));
    });
  }

  void updateProfile({
    String? cover,
    String? profileImage,
    String? name,
    String? phone,
    String?bio
  }) {
    emit(SocialLoadingUpdateUserState());
    LoginModel updatedData = LoginModel(
        email: model!.email,
        uId: model!.uId,
        cover: cover ?? model!.cover,
        bio: bio ?? model!.bio ?? '',
        name: name ?? model!.name!,
        phone: phone ?? model!.phone,
        isEmailVerified: model!.isEmailVerified,
        image: profileImage ?? model!.image
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .set(updatedData.toMap())
        .then((value) {
          getUser();
           emit(SocialSuccessUpdateUserState());
    })
        .catchError((error) {
      emit(SocialErrorUpdateUserState(error.toString()));
    });
  }

  File? postImageFile;
  Future getPostImage() async
  {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImageFile = File(pickedFile.path);
      emit(SocialSuccessGetPostImageState());
    } else {
      emit(SocialErrorGetPostImageState());
    }
  }

  void uploadPostImage
  ({
    String? dateTime,
    String? postText,
}){
  emit(SocialLoadingUploadPostImageState());
  FirebaseStorage.instance
      .ref()
      .child('posts/${Uri.file(postImageFile!.path).pathSegments.last}')
      .putFile(postImageFile!)
      .then((value){
        value.ref.getDownloadURL()
        .then((value){
            emit(SocialSuccessUploadPostImageState());
            createPost(
                dateTime: dateTime,
                postImage: value,
                postText: postText,
            );
        })
        .catchError((error){
            emit(SocialErrorUploadPostImageState(error));

        });
      })
      .catchError((error){
          emit(SocialErrorUploadPostImageState(error));

      });
  }

  void createPost({
    String? postImage,
    String? dateTime,
    String? postText,
  }) {
    emit(SocialLoadingCreatePostState());
    AddPostModel postModel = AddPostModel(
        name: model!.name,
        uId: uId!,
        image: model!.image,
        dateTime: dateTime,
        postText: postText,
        postImage: postImage
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      getUser();
      getPosts();
      emit(SocialSuccessCreatePostState());
    })
        .catchError((error) {
      emit(SocialErrorCreatePostState(error.toString()));
    });
  }

  void removePostImage() {
    postImageFile = null;
    emit(SocialRemovePostImageState());
  }

  List<AddPostModel> postModel = [];
  List<String> postIds = [];
  List<int> likes = [];
  List<String> comments = [];
  List<int> commentsNumber = [];

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {
          for (var element in value.docs) {

            element.reference.collection('likes').get()
            .then((value){
              likes.add(value.size);
              postModel.add(AddPostModel.fromJson(element.data()));
            }).catchError((error){
              emit(SocialGetPostsErrorState(error));
            });
            postIds.add(element.id);

            element.reference.collection('comments').get()
            .then((value){
              commentsNumber.add(value.size);
              for (var element in value.docs) {
                comments.add(element['comment']);
              }
              emit(SocialAddCommentSuccessState());
            }).catchError((error){
              emit(SocialAddCommentErrorState(error.toString()));
            });

          }
          emit(SocialGetPostsSuccessState());
        })
        .catchError((error) {
          emit(SocialGetPostsErrorState(error));
        });
  }

  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({
          'like':true
        }).then((value){
          emit(SocialLikePostSuccessState());
        }).catchError((error){
          emit(SocialLikePostErrorState(error.toString()));
        });
  }

  void addComment(String postId , String text){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.uId)
        .set({
      'comment':text
    }).then((value){
      emit(SocialAddCommentSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialAddCommentErrorState(error.toString()));
    });
  }
  
  List<LoginModel> usersModel = [];
  void getAllUsers() {
    emit(SocialGetUsersLoadingState());
    FirebaseFirestore.instance.collection('user')
        .get()
        .then((value) {
          for (var element in value.docs) {
            if(element.data()['uId']!= uId!) {
              usersModel.add(LoginModel.fromJson(element.data()));
            }
          }
      emit(SocialGetUsersSuccessState());
    })
        .catchError((error) {
      emit(SocialGetUsersErrorState(error));
    });
  }

  void sendMessages({
    required String textMessage,
    required String receiverId,
    required String dateTime
}){
    ChatModel model = ChatModel(
        senderId: uId!, 
        receiverId: receiverId, 
        dateTime: dateTime, 
        textMessage: textMessage
    );
    
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
          emit(SocialSendMessageSuccessState());
        })
        .catchError((error){
          emit(SocialSendMessageErrorState(error.toString()));
        });

    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(uId!)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }
  List<ChatModel> chatModel = [];
  void getMessages(receiverId){
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()  //for live data
        .listen((event) {
          chatModel = [];
          for (var element in event.docs) { 
            chatModel.add(ChatModel.fromJson(element.data()));
          }});
    emit(SocialGetMessageSuccessState());
  }

  void signOut(BuildContext context){
    clearAllData();
    FirebaseAuth.instance.signOut().then((value){
      CacheHelper.clearAllData().then((value){
        if(value){
          navigateAndFinish(context: context, route: LoginScreen());
        }
      });
    });

  }
  void clearAllData(){
    model = null;
    chatModel = [];
    usersModel = [];
    commentsNumber = [];
    comments = [];
    postIds = [];
    likes = [];
    profileImage = null;
    postImageFile = null;
    postModel = [];
    coverImage = null;
  }


}