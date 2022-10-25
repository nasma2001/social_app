import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/layouts/cubit/SocialCubit.dart';
import 'package:social_app/layouts/cubit/SocialStates.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/modules/login/LoginScreen.dart';
import 'package:social_app/modules/register/Register.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/CacheHelper.dart';
import 'package:social_app/styles/themes.dart';

int? initScreen;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CacheHelper.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  uId =await CacheHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>SocialCubit()..getUser()..getPosts()..getAllUsers()
        ),
      ], child:BlocConsumer<SocialCubit,SocialStates>(
              builder: (context,state)=>MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: light,
                darkTheme: dark,
                initialRoute:  initScreen == 0 || initScreen == null ? "first" : "second",
                routes: {
                  'second': (context) => uId != null?const SocialScreen():LoginScreen(),
                  "first": (context) => LoginScreen(),
                },
              ),
              listener: (context,state){

              },
      ),
    );
  }
}

