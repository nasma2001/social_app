

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_layout.dart';

import '../../shared/components/components.dart';
import 'ShopRegisterCubit.dart';
import 'ShopRegisterStates.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit(),
        child:BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
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
                      'Register',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                        'Register to communicate with your friends',
                        style:Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey
                        )
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    defTextEditing(
                        controller: nameController,
                        validate: (input){
                          if(input==null ||input.isEmpty){
                            return 'Name must not be empty';
                          }
                        },
                        isPassword: false,
                        label: 'Name',
                        prefix: Icons.person),
                    const SizedBox(
                      height: 30,
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
                        controller: phoneController,
                        validate: (input){
                          if(input==null ||input.isEmpty){
                            return 'Phone must not be empty';
                          }
                        },
                        isPassword: false,
                        label: 'Phone',
                        prefix: Icons.phone),
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
                        isPassword: SocialRegisterCubit.get(context).isPassword,
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialRegisterCubit.get(context).passwordVisibilityIcon,
                        suffixPressed: (){
                          SocialRegisterCubit.get(context).changePasswordVisibility();
                        },
                        onSubmit: (value){
                          if(formKey.currentState!.validate()){
                            SocialRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                            );
                          }
                        }
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ConditionalBuilder(
                      condition: state is! SocialLoadingRegisterState,
                      builder: (context)=>defaultButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            SocialRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                            );
                          }
                        },
                        width: double.infinity,
                        text: 'Register',
                        context: context,
                        isUpper: false,
                      ),
                      fallback:(context)=>const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        listener: (context,state){
          if(state is SocialSuccessCreateUserState){
            navigateAndFinish(
                context: context,
                route: const SocialScreen()
            );
          }
          if(state is SocialErrorCreateUserState){
            toast(msg: state.error, state: ToastStates.error);
          }
        },
      ),
    );
  }
}
