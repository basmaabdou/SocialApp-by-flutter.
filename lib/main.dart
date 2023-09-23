import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observed.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/componant/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/theme.dart';
// import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print('on background message');
  print(message.data.toString());
  messageToast(msg: 'On background Message', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// firebase
  await Firebase.initializeApp();
  //notification
  //foreground fcm
  var token= await FirebaseMessaging.instance.getToken();
  print(token);
  //الابليكشن مفتوح وشغال عليه
  FirebaseMessaging.onMessage.listen((event) {
    print('on message');
    print(event.data.toString());
    messageToast(msg: 'On Message', state: ToastStates.SUCCESS);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message opened app');
    print(event.data.toString());
    messageToast(msg: 'On Message Opened App', state: ToastStates.SUCCESS);
  });
  //background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPosts()),
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
