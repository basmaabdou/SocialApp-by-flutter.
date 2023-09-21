import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observed.dart';
import 'package:social_app/shared/componant/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase
  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();


 uId=CacheHelper.getData(key: 'uId');
  Widget widget;

  if(uId != null){
    widget=SocialHomeLayout();
  }else{
    widget=LoginScreen();
  }



  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  // final bool? isDark;
  const MyApp({this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SocialCubit()..getUserData()),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home:startWidget,
      ),
    );
  }
}
