import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialFeeds extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              itemBuilder: (context,index)=>buildPostItem(context),
              separatorBuilder: (context,index)=> SizedBox(
                height: 8,
              ),
              itemCount: 10
          )
        ],
      ),
    );
  }

  Widget buildPostItem(context)=> Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(
        horizontal: 10
    ),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/free-photo/order-registration_1098-16196.jpg?w=1060&t=st=1693758325~exp=1693758925~hmac=1bc95e0e63edee075305cf5f5f204b471af6dad235cca142a7c82583f6cbcd1b'
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
                      'Basma Mohamed',
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
                  'january 10/2022',
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
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Container(
          width: double.infinity,
          child: Wrap(
            children: [
              Padding(
                padding:  EdgeInsetsDirectional.only(end: 5),
                child: Container(
                    height: 25,
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                          )
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    )
                ),
              ),
              Padding(
                padding:  EdgeInsetsDirectional.only(end: 5),
                child: Container(
                    height: 25,
                    child: MaterialButton(
                      onPressed: (){},
                      child: Text(
                          '#software',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Colors.blue,
                          )
                      ),
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                    )
                ),
              ),

            ],
          ),
        ),
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage('https://img.freepik.com/free-photo/close-up-male-hands-using-tablet-with-blank-screen_155003-37639.jpg?w=1060&t=st=1693757666~exp=1693758266~hmac=706c68af619bb1a073dc60a1410727fd342493dbf4205c593ad9f53285c4175f'),
                fit: BoxFit.cover,

              )
          ),
        ),
        Row(
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
                      '120',
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
                      '80 comment',
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
                          'https://img.freepik.com/free-photo/order-registration_1098-16196.jpg?w=1060&t=st=1693758325~exp=1693758925~hmac=1bc95e0e63edee075305cf5f5f204b471af6dad235cca142a7c82583f6cbcd1b'
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
