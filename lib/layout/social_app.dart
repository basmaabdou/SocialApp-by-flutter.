import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/modules/notification/notification.dart';
import 'package:social_app/modules/post/post.dart';
import 'package:social_app/modules/search/search.dart';
import 'package:social_app/shared/componant/componant.dart';

import '../shared/styles/icon_broken.dart';

class SocialHomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state)
      {
        if(state is SocialNewPosts){
          navigateTo(context, NewPosts());
        }
      },
      builder: (BuildContext context, SocialStates state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                cubit.titles[cubit.currentIndex]
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SocialNotification());
                  },
                  icon: Icon(IconBroken.Notification)
              ),
              IconButton(
                  onPressed: (){
                    navigateTo(context, SocialSearch());
                  },
                  icon: Icon(IconBroken.Search)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                  label: 'Chat'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                  label: 'Post',
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location,),
                  label: 'Users'
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Setting'
              ),
            ],

          ),
        );
      },
    );
  }
}
