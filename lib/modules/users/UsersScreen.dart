
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layouts/cubit/SocialCubit.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ConditionalBuilder(
          condition: SocialCubit.get(context).usersModel.isNotEmpty,
          builder: (context)=> ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index)=>Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  CircleAvatar(
                    backgroundImage:NetworkImage(SocialCubit.get(context).model!.image!),
                    radius: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                          SocialCubit.get(context).model!.name!
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ],
              ),
              separatorBuilder: (context, index)=>const SizedBox(height: 20,),
              itemCount: SocialCubit.get(context).usersModel.length
          ),
          fallback:(context)=> const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}