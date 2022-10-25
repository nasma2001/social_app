
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../layouts/cubit/SocialCubit.dart';
import '../../layouts/cubit/SocialStates.dart';
import '../../models/LoginModel.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    LoginModel? model = SocialCubit.get(context).model;

    nameController.text = model!.name!;
    bioController.text = model.bio == null?'':model.bio!;
    phoneController.text = model.phone!;

    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (context,state)=>Scaffold(
        appBar: defaultAppBar(
          title: 'Edit Profile',
          leadingOnPressed: (){
            Navigator.pop(context);
          },
          actions: [
            defaultTextButton(
                text: 'Update',
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    if(cubit.profileImage != null && cubit.coverImage == null){
                      cubit.uploadProfileImage(
                          nameController.text,
                          bioController.text,
                          phoneController.text
                      );
                    }
                    else if(cubit.profileImage == null && cubit.coverImage != null){
                      cubit.uploadCoverImage(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text
                      );
                    }
                    else if(cubit.profileImage != null && cubit.coverImage != null){

                      cubit.uploadProfileImage(
                          nameController.text,
                          bioController.text,
                          phoneController.text
                      );
                      cubit.uploadCoverImage();

                    }
                    else if(cubit.profileImage == null && cubit.coverImage == null){
                      cubit.updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text
                      );
                    }
                  }
                }
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),   //AppBar
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children:[
                SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10)
                          ),
                          child: Stack(
                            children: [
                              Image(
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: SocialCubit.get(context).coverImage == null
                                    ?NetworkImage(model.cover!)
                                    :FileImage(SocialCubit.get(context).coverImage!) as ImageProvider,
                              ),
                              InkWell(
                                child: Container(
                                  color:defaultColor.withOpacity(0.2) ,
                                  width: double.infinity,
                                  height: 200,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 40,
                                  ),
                                ),
                                onTap: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 61,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:SocialCubit.get(context).profileImage == null
                                  ? NetworkImage(model.image!)
                                  :FileImage(SocialCubit.get(context).profileImage!) as ImageProvider,
                            ),
                            InkWell(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: defaultColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white.withOpacity(0.7),
                                  size: 40,
                                ),
                              ),
                              onTap: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defTextEditing(
                          controller: nameController,
                          validate: (value){
                            if (value!.isEmpty || value == null){
                                return 'name must not be empty';
                            }
                            return null;
                          },
                          isPassword: false,
                          label: 'Name',
                          prefix: Icons.person
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defTextEditing(
                          controller: bioController,
                          validate: (value){
                            return null;
                          },
                          isPassword: false,
                          label: 'Bio',
                          prefix: Icons.edit
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defTextEditing(
                          controller: phoneController,
                          validate: (value){
                            if (value!.isEmpty || value == null){
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          isPassword: false,
                          label: 'Phone',
                          prefix: Icons.phone_android
                      ),
                    ],
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                if(state is SocialLoadingUpdateUserState || state is SocialLoadingUploadCoverState ||
                   state is SocialLoadingUploadProfileImageState || state is SocialGetUserLoadingState)
                  const LinearProgressIndicator()
              ],
            ),
          ),
        ),
      ),
      listener: (context, state){
        if (state is SocialGetUserSuccessState){
          cubit.getUser();
          toast(msg: 'Updated Successfully', state: ToastStates.success);
          navigateAndFinish(context: context, route: const SocialScreen());

        }else if(state is SocialErrorUpdateUserState){
          toast(msg: state.error!, state: ToastStates.error);
        }else if(state is SocialSuccessUploadProfileImageState || state is SocialSuccessUploadCoverState) {
          cubit.getUser();
        }
      },
    );
  }
}
