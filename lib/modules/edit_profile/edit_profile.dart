import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/componant/componant.dart';

import '../../shared/styles/icon_broken.dart';


class EditProfile extends StatelessWidget {

  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        var userModel=SocialCubit.get(context).userModel;
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=userModel!.name!;
        bioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;

        return  Scaffold(
          appBar:AppBar(
            title:  Text(
                'Edit Posts'
            ),
            titleSpacing: 0,
            leading:  IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon:  Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            actions: [
              defaultTextButton(
                  function: (){
                    SocialCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'Update'),
               SizedBox(
                width: 15,
              )
            ],
          ),
          body:  Padding(
            padding:  EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUserUpdateLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
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
                                      image: (coverImage == null) ? NetworkImage(
                                          '${userModel.cover}'
                                      )  : FileImage(coverImage)as ImageProvider,
                                      fit: BoxFit.cover,
                                    )

                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon:  CircleAvatar(
                                    radius: 20,
                                    child: Icon(IconBroken.Camera,size: 18,)
                                )
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: (profileImage == null)
                                    ? NetworkImage('${userModel.image}') as ImageProvider<Object>?
                                    : FileImage(profileImage),
                              ),
                              IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon:  CircleAvatar(
                                      radius: 20,
                                      child: Icon(IconBroken.Camera,size: 18,)
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 20,
                  ),
                  if(profileImage !=null || coverImage !=null)
                    Row(
                        children: [
                          if(profileImage !=null)
                            Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                    onPressed: (){
                                      SocialCubit.get(context).uploadProfileImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text
                                      );
                                    },
                                    child: Text('Upload Profile')
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          if(coverImage !=null)
                            Expanded(
                            child: Column(
                              children: [
                                OutlinedButton(
                                    onPressed: (){
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text
                                      );
                                    },
                                    child: Text('Upload Cover')
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator()
                              ],
                            ),
                          ),
                        ],
                      ),
                  if(profileImage !=null || coverImage !=null)
                    SizedBox(
                      height: 10,
                    ),
                  defaultTextForm(
                      controller: nameController,
                      type: TextInputType.name,
                      labelText: 'UserName',
                      validate: (value){
                        if(value.isEmpty){
                          return 'name must be not empty';
                        }
                        return null;
                      },
                      prefix: IconBroken.User
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  defaultTextForm(
                      controller: bioController,
                      type: TextInputType.text,
                      labelText: 'Bio',
                      validate: (value){
                        if(value.isEmpty){
                          return 'bio must be not empty';
                        }
                        return null;
                      },
                      prefix: IconBroken.Info_Circle
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultTextForm(
                      controller: phoneController,
                      type: TextInputType.phone,
                      labelText: 'Phone',
                      validate: (value){
                        if(value.isEmpty){
                          return 'phone must be not empty';
                        }
                        return null;
                      },
                      prefix: IconBroken.Call
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



}
