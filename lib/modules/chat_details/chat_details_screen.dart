import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {

  var messageController=TextEditingController();

  SocialUserModel? userModel;
  MessageModel? messageModel;
  ChatDetailsScreen({
    this.userModel,
    this.messageModel
});



  @override
  Widget build(BuildContext context) {
    return  Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (BuildContext context, SocialStates state) {  },
          builder: (BuildContext context, SocialStates state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          userModel!.image!
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      userModel!.name!,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length >0,
                builder: (BuildContext context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                              var message=SocialCubit.get(context).messages[index];
                              if(SocialCubit.get(context).userModel!.uId == message.senderId){
                                 return buildMyMessage(message,context);
                              }else{
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder:(context,index)=> SizedBox(
                              height: 5,
                            ),
                            itemCount: SocialCubit.get(context).messages.length
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
                                // SocialCubit.get(context).sendImageMessage(photo: messageModel!.photo!,
                                //   receiverId: userModel!.uId!,
                                //   dateTime: DateTime.now().toString(),
                                //   text: messageController.text,);
                              },

                              icon:  CircleAvatar(
                                  radius: 20,
                                  child: Icon(Icons.close,size: 18,)
                              )
                          ),
                        ],
                      ),
                      // Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(.3),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 10,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ...'
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getPostImage();
                                },
                                icon:  CircleAvatar(
                                    radius: 20,
                                    child: Icon(IconBroken.Camera,size: 18,)
                                )
                            ),
                            Container(
                              color: defaultColor,
                              height: 50,
                              width: 50,
                              child: MaterialButton(
                                onPressed: (){
                                  SocialCubit.get(context).sendMessage(
                                      receiverId: userModel!.uId!,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                     // photo: messageModel!.photo,
                                  );
                                },
                                child: Icon(IconBroken.Send, color: Colors.white,size: 16,),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          )
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model,context) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
          ),
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(.2),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )
          ),
          child: Text(
              '${model.text}'
          ),
        ),
        // if(SocialCubit.get(context).photo != '')
        // Image(image: NetworkImage('${model.photo}')),

      ],
    ),
  );
}
