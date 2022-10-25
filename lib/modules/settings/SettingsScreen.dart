
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';
import 'package:social_app/models/LoginModel.dart';

import '../../shared/components/components.dart';
import '../editProfile/EditProfileScreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    LoginModel? model = SocialCubit.get(context).model;
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (context,state)=>ConditionalBuilder(
        builder: (context)=>SingleChildScrollView(
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
                          child: Image(
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: NetworkImage(model!.cover!),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 61,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(model.image!),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  model.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child:Text(
                    model.bio ?? 'write your bio ...',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54
                    ),
                  ),
                  onTap: (){},
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '230',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('posts')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '200',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('photos')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '20',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('followers')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: const [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '255',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('followings')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(onPressed:(){},
                        child: const Text(
                            'Add Photos'
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: (){
                          navigate(
                              context: context,
                              route: const EditProfileScreen()
                          );
                        },
                        child: const Icon(
                            Icons.edit
                        )
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        fallback: (context)=>const Center(child: CircularProgressIndicator()),
        condition: model != null,
      ),
      listener: (context, state){

      },
    );
  }
}