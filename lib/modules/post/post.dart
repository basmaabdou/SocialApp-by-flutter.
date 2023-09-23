import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/componant/componant.dart';

import '../../shared/styles/icon_broken.dart';


class NewPosts extends StatelessWidget {


  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'create posts'
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
                    var now= DateTime.now();
                    if(SocialCubit.get(context).postImage ==null){
                      SocialCubit.get(context).createPost(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text
                      );
                    }
                  },
                  text: 'POST'
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(state is SocialCreateLoadingPost)
                  LinearProgressIndicator(),
                if(state is SocialCreateLoadingPost)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/woman-drinking-hot-chocolate-cafe_23-2149944070.jpg?t=st=1695280382~exp=1695280982~hmac=0a6f0415eba4d1853be96932652e2343ffed2ba9aae24495fc9bf4c527809127'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Basma Mohamed'
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Profile',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'what is in your mind ... ',
                      border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(4),
                            image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            )

                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          SocialCubit.get(context).removePostImage();
                        },
                        icon:  CircleAvatar(
                            radius: 20,
                            child: Icon(Icons.close,size: 18,)
                        )
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                        children: [
                          IconButton(
                              onPressed: (){},
                              icon: Icon(IconBroken.Image)
                          ),
                          Text('add photos')
                        ],
                      )
                      ),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){}, child: Text('# tags')),
                    ),
                   ],
                )
              ],
            ),
          ),
        );
      },
    );
  }



}
