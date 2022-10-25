
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';
import 'package:social_app/modules/addPost/AddPost.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';

import 'cubit/SocialCubit.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) =>
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () { SocialCubit.get(context).signOut(context); },
                  icon: const Icon(
                    Icons.logout,
                    color: defaultColor,
                  ),
                ),
                titleSpacing: 0,
                title: Text(
                  SocialCubit.get(context).titles[SocialCubit.get(context).currentIndex],
                ),
                actions: [
                  IconButton(
                      onPressed: (){

                      },
                      icon: const Icon(
                          Icons.notifications
                      )
                  ),
                  IconButton(
                      onPressed: (){

                      },
                      icon: const Icon(
                          Icons.search
                      )
                  ),

                ],
              ),
              body:SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: SocialCubit.get(context).currentIndex,
                items: const [
                  BottomNavigationBarItem(
                        icon:Icon(
                            Icons.home_filled
                        ),
                      label:'Home'
                    ),
                  BottomNavigationBarItem(
                      icon:Icon(
                          Icons.wechat_rounded
                      ),
                    label: 'Chats'
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add_circle_outline
                      ),
                    label: 'Post'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(
                          Icons.supervised_user_circle
                      ),
                    label: 'Users'
                  ),
                  BottomNavigationBarItem(
                      icon:Icon(
                          Icons.settings
                      ),
                    label: 'Settings'
                  ),
                ],
                onTap: (index){
                  SocialCubit.get(context).changeBtmNavBar(index);
                },
              ),
           ),
    listener: (context,state){
          if(state is SocialAddPostState){
            navigate(
                context: context,
                route: const AddPostScreen()
            );
          }
    },
    );
  }

}
// if(!FirebaseAuth.instance.currentUser!.emailVerified)
//   Container(
//     color: Colors.amber[100],
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         children:  [
//           const Icon(
//             Icons.warning,
//             color: defaultColor,
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           const Text(
//             'Verify your Email',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold
//             ),
//           ),
//           const Spacer(),
//           defaultTextButton(
//               onPressed: (){
//                 FirebaseAuth.instance.currentUser!
//                     .sendEmailVerification()
//                     .then((value) {
//                   toast(msg: 'check your inbox', state: ToastStates.success);
//                 }).catchError((error){
//                   toast(msg: error.toString(), state: ToastStates.error);
//
//                 });
//               },
//               text: 'send',
//               isUpper: true
//           ),
//         ],
//       ),
//     ),
//   ),