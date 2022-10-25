import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';

import '../../models/AddPostModel.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state){} ,
      builder: (context,state)=>SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConditionalBuilder(
              condition: SocialCubit.get(context).postModel.isNotEmpty && SocialCubit.get(context).model != null,
              builder: (context){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            const Image(
                              image: NetworkImage('https://img.freepik.com/free-vector/illustration-social-media-concept_53876-17828.jpg?w=740&t=st=1662042485~exp=1662043085~hmac=5f0a5c95fe53cc32bd405979d82c2e1d2593aff7e1db2f3bd04ae8997edf9289'),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                color: defaultColor[300],
                                child: const Text(
                                  'Communicate with friends',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true ,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index)=>listItem(SocialCubit.get(context).postModel[index], index, context),
                        separatorBuilder: (context, builder)=>const SizedBox(height: 0,),
                        itemCount: SocialCubit.get(context).postModel.length
                    ),
                  ],
                );
              },
              fallback: (context)=>const Center(child: CircularProgressIndicator())
        ),
      ),
    );
  }
  Widget listItem(AddPostModel model, index , context)=>Padding(
    padding: const EdgeInsets.all(10),
    child: Card(
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            model.name!
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 15,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.dateTime!,
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12
                      ),
                    )
                  ],
                ),
                const Spacer(),
                IconButton(
                    onPressed:(){},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black54,
                    )
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[300],
            width: double.infinity,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.postText!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 22,
                          child: defaultTextButton(
                            text: '#software',
                            textColor: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(model.postImage != '')
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image:NetworkImage(model.postImage!),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            color: defaultColor,
                            size: 17,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                    const Spacer(),
                    InkWell(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.chat_bubble_rounded,
                            color: Colors.blue,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            '${SocialCubit.get(context).commentsNumber[index]}',
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                      onTap: (){},
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    CircleAvatar(
                      backgroundImage:NetworkImage(model.image!),
                      radius: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          controller: commentController,
                          decoration: const InputDecoration(
                              hintText:'Write a comment ...',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                              border: InputBorder.none
                          ),
                        onFieldSubmitted:(value){
                          SocialCubit.get(context).addComment(
                              SocialCubit.get(context).postIds[index], commentController.text
                          );
                        },

                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: defaultColor,
                            size: 15,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        SocialCubit.get(context).likePost(SocialCubit.get(context).postIds[index]);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}