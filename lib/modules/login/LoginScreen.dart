
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layouts/social_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/CacheHelper.dart';
import '../register/Register.dart';
import 'SocialCubit.dart';
import 'SocialStates.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child:BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        builder: (context,state)=>Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        'Login to contact with friends from around the world!',
                        style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        )
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defTextEditing(
                        controller: emailController,
                        validate: (input){
                          if(input==null ||input.isEmpty){
                            return 'Email must not be empty';
                          }
                        },
                        isPassword: false,
                        label: 'Email',
                        prefix: Icons.email),
                    const SizedBox(
                      height: 30,
                    ),
                    defTextEditing(
                        controller: passwordController,
                        validate: (input){
                          if(input==null ||input.isEmpty){
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialLoginCubit.get(context).passwordVisibilityIcon,
                        suffixPressed: (){
                          SocialLoginCubit.get(context).changePasswordVisibility();
                        },
                        onSubmit: (value){
                          if(formKey.currentState!.validate()){
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context
                            );
                          }
                        }
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ConditionalBuilder(
                        condition: state is! SocialLoadingLoginState,
                        builder: (context)=>defaultButton(
                          onPressed: (){
                            if(formKey.currentState!.validate()){
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context
                              );
                            }
                          },
                          width: double.infinity,
                          text: 'Login',
                          context: context,
                          isUpper: false,
                        ),
                      fallback:(context)=>const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        const Text(
                            'Don\'t have an account?'
                        ),
                        defaultTextButton(
                            text: 'SIGN UP HERE',
                            isUpper: true,
                            onPressed: (){
                              navigateAndFinish(context: context, route: RegisterScreen());
                            }
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        listener: (context,state){
          if(state is SocialSuccessLoginState){
            CacheHelper.putData(
                key: 'uId',
                value: state.uId
            );
            uId = state.uId;
            navigateAndFinish(
                context: context,
                route: const SocialScreen()
            );
          }
          if(state is SocialErrorLoginState){
            toast(msg: state.error!, state: ToastStates.error);
          }
        },
      ),
    );
  }
}
