
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../layouts/cubit/SocialStates.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          title: const Text(
              'addPost'
          ),
          leading: const Icon(Icons.arrow_back_ios),
          actions: [
            if(state is! SocialLoadingCreatePostState)
            defaultTextButton(
                text: 'Post',
                fontWeight: FontWeight.w500,
                onPressed: (){
                  if(cubit.postImageFile == null){
                    cubit.createPost(
                        postText: textController.text,
                        dateTime: DateTime.now().toString(),
                    );
                  }else{
                    cubit.uploadPostImage(
                        dateTime : DateTime.now().toString(),
                        postText: textController.text
                    );
                  }
                },
                fontSize: 16
            ),

            if(state is SocialLoadingCreatePostState)
              const SizedBox(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(),
              ),
            const SizedBox(width: 10,)
          ],
        ),
        body: ConditionalBuilder(
          condition: cubit.model != null,
          builder: (context)=>Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    CircleAvatar(
                      backgroundImage:NetworkImage(cubit.model!.image!),
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      cubit.model!.name!,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: textController,
                        decoration: InputDecoration(
                            hintText:"what's in your mind ${cubit.model!.name!} ? ",
                            hintStyle: const TextStyle(
                                fontSize: 14
                            ),
                            border: InputBorder.none
                        )
                    ),
                  ),
                ),
                if(cubit.postImageFile != null)
                  Flexible(
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image:cubit.postImageFile != null ? FileImage(cubit.postImageFile!):
                            const NetworkImage('') as ImageProvider,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            cubit.removePostImage();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: defaultColor.withOpacity(0.3),
                            elevation: 0,
                          ),
                          child: const Icon(
                            Icons.close,
                          ),

                        )
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        highlightColor: defaultColor[100],
                        textColor: defaultColor,
                        onPressed: (){
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.photo,
                              color: defaultColor,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              'Add Photo',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal
                              ),
                            )
                          ],
                        ) ,
                      ),
                    ),
                    Expanded(
                      child: defaultTextButton(
                        text: '#Tags',
                        onPressed: (){},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        ),
      ),
      listener: (context, state){
        if (state is SocialSuccessCreatePostState) {
          Navigator.pop(context);
        }
      },
    );
  }
}
