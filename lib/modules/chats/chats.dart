import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/componant/componant.dart';

import '../chat_details/chat_details_screen.dart';

class SocialChats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {  
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          builder: (BuildContext context) =>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index) => buildChatItem(SocialCubit.get(context).users[index],context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (BuildContext context)  =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model,context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              '${model.image}'
                ),

          ),
          SizedBox(
            width: 10,
          ),
          Text(
              '${model.name}'
          )
        ],
      ),
    ),
  );
}
