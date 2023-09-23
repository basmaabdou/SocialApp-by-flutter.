import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/componant/componant.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialFeeds extends StatelessWidget {
var commentController=TextEditingController();
   @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length >0 && SocialCubit.get(context).userModel !=null,
          builder: (BuildContext context) =>SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children:[
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/portrait-young-people-with-thought-bubble_23-2149184866.jpg?w=1060&t=st=1695413974~exp=1695414574~hmac=27e2c63256ebf3afbff2343911b1682c859dc6e67dc70623a7f75bbfd50e492c'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with your friends',
                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index),
                    separatorBuilder: (context,index)=> SizedBox(
                      height: 8,
                    ),
                    itemCount: SocialCubit.get(context).posts.length
                )
              ],
            ),
          ),
          fallback: (BuildContext context)  =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(postModel model,context, index)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(
        horizontal: 10
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                '${model.image}'
                  ),

            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(
                          height: 1.4
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: defaultColor,
                      size: 17,
                    )
                  ],
                ),
                Text(
                  '${model.dateTime}',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.4
                  ),
                )
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: (){},
              icon:Icon(Icons.more_horiz,
                size: 25,
              ),),
          ],
        ),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Text(
          '${model.text}',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        // Container(
        //   width: double.infinity,
        //   child: Wrap(
        //     children: [
        //       Padding(
        //         padding:  EdgeInsetsDirectional.only(end: 5),
        //         child: Container(
        //             height: 25,
        //             child: MaterialButton(
        //               onPressed: (){},
        //               child: Text(
        //                   '#software',
        //                   style: Theme.of(context).textTheme.caption!.copyWith(
        //                     color: Colors.blue,
        //                   )
        //               ),
        //               minWidth: 1,
        //               padding: EdgeInsets.zero,
        //             )
        //         ),
        //       ),
        //       Padding(
        //         padding:  EdgeInsetsDirectional.only(end: 5),
        //         child: Container(
        //             height: 25,
        //             child: MaterialButton(
        //               onPressed: (){},
        //               child: Text(
        //                   '#software',
        //                   style: Theme.of(context).textTheme.caption!.copyWith(
        //                     color: Colors.blue,
        //                   )
        //               ),
        //               minWidth: 1,
        //               padding: EdgeInsets.zero,
        //             )
        //         ),
        //       ),

        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),

        if(model.postImage != null)
          Padding(
            padding: const EdgeInsetsDirectional.only(
                top: 15
            ),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,

                  )
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            vertical: 5
          ),
          child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red[300],
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[500]
                          ),
                        ),

                      ],
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).comment[index]}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey[500]
                          ),
                        ),

                      ],
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 5),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel!.image}'
                      ),

                    ),
                    SizedBox(
                      width: 30,
                    ),
                    // Expanded(
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //         hintText: 'write your mind ...'
                    //     ),),
                    // ),
                    Text(
                      'write a comment ......',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: (){
                  SocialCubit.get(context).commentPost(SocialCubit.get(context).postId[index]);
                },
              ),
            ),
            InkWell(
              child: Row(
                children: [
                  Icon(
                    IconBroken.Heart,
                    color: Colors.red[300],
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Like',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.grey[500]
                    ),
                  ),

                ],
              ),
              onTap: (){
                SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);
              },
            ),
          ],
        ),

      ],
    ),
  );
}
