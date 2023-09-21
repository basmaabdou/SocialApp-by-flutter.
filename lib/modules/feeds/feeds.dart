import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/cubit/cubit.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialFeeds extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, SocialStates state) {  },
      builder: (BuildContext context, SocialStates state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length >0,
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
                          image: NetworkImage('https://img.freepik.com/free-photo/close-up-male-hands-using-tablet-with-blank-screen_155003-37639.jpg?w=1060&t=st=1693757666~exp=1693758266~hmac=706c68af619bb1a073dc60a1410727fd342493dbf4205c593ad9f53285c4175f'),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
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
                    itemBuilder: (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context),
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

  Widget buildPostItem(postModel model,context)=> Card(
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
                          '0',
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
                          '0 comment',
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
                      width: 5,
                    ),
                    Text(
                      'write a comment ......',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: (){},
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
              onTap: (){},
            ),
          ],
        )
      ],
    ),
  );
}
