
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';
import 'package:social_app/models/ChatModel.dart';
import 'package:social_app/shared/components/constants.dart';

import '../../models/LoginModel.dart';

class ChatDetailsScreen extends StatelessWidget {
  LoginModel? model;

  ChatDetailsScreen(this.model, {super.key});
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(model!.uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          builder: (context, state)=>Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(model!.image!),
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                      model!.name!
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child:Column(
                children: [
                  ConditionalBuilder(
                    condition:SocialCubit.get(context).chatModel.isNotEmpty ,
                    builder: (context)=>Flexible(
                      fit: FlexFit.tight,
                      child: ListView.separated(
                          itemBuilder: (context, index){
                            ChatModel chat = SocialCubit.get(context).chatModel[index];
                            if(chat.senderId == uId ) {
                              return senderMessage(chat);
                            }
                            return receiverMessage(chat);
                          },
                          separatorBuilder: (context, index)=>const SizedBox(height: 5,),
                          itemCount: SocialCubit.get(context).chatModel.length
                      ),
                    ),
                    fallback: (context)=>const Center(child: CircularProgressIndicator()),
                  ),
                  if(SocialCubit.get(context).chatModel.isEmpty)
                    const Spacer(),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: textController,
                          onFieldSubmitted: (value){
                            SocialCubit.get(context).sendMessages(
                                textMessage: textController.text,
                                receiverId: model!.uId,
                                dateTime: DateTime.now().toString()
                            );
                            textController.text = '';
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: 'Type a message ...',
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.send,
                              ),
                              onPressed: (){
                                SocialCubit.get(context).sendMessages(
                                    textMessage: textController.text,
                                    receiverId: model!.uId,
                                    dateTime: DateTime.now().toString()
                                );
                                textController.text = '';
                              },
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                      ),
                    ],
                  )
                ],

          ),)
          ),
          listener: (context, state){},
        );
      }
    );
  }
  Widget receiverMessage(ChatModel chat)=>Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            chat.textMessage,
          ),
        ),
      ),
    ],
  );

  Widget senderMessage(ChatModel chat)=> Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10)
          ),
          color: defaultColor.withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            chat.textMessage,
          ),
        ),
      ),
    ],
  );


}
