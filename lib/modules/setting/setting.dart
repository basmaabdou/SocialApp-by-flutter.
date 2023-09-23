import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

import '../edit_profile/edit_profile.dart';

class SocialSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state)
      {
        var userModel=SocialCubit.get(context).userModel;

        return  Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 180,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:  BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight:  Radius.circular(4),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${userModel!.cover}'),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            '${userModel.image}'
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${userModel.bio} ',
                style: Theme.of(context).textTheme.caption,
              ),
               SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '300',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'posts ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'photos ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '10k',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Followers ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '1k',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Following ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
               SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {  },
                      child:  Text(
                        'Add Photos'
                      ),
                    )
                  ),
                   SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                      onPressed: (){
                        navigateTo(context,  EditProfile());
                      },
                      child:  Icon(IconBroken.Edit,size: 17,)
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(onPressed: (){
                    navigateFinish(context, LoginScreen());
                  }, child: Text('LogOut'))
                ],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: ()
                    {
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    },
                    child: Text(
                      'subscribe',
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                    },
                    child: Text(
                      'unsubscribe',
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
