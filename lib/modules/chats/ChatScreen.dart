import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';
import 'package:social_app/models/LoginModel.dart';
import 'package:social_app/modules/chatDetails/ChatDetails.dart';
import 'package:social_app/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state)=>Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ConditionalBuilder(
            condition: SocialCubit.get(context).usersModel.isNotEmpty,
            builder: (context)=> ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index)=>listItem(SocialCubit.get(context).usersModel[index], context),
                separatorBuilder: (context, index)=>const SizedBox(height: 20,),
                itemCount: SocialCubit.get(context).usersModel.length
            ),
            fallback:(context)=> const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      listener: (context, state){},
    );
  }
  Widget listItem(LoginModel model, context)=> Card(
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  CircleAvatar(
                    backgroundImage:NetworkImage(model.image!),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                          model.name!
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: (){
              navigate(
                  context: context,
                  route: ChatDetailsScreen(model)
              );
            },
          ),
        ),
      );
}
