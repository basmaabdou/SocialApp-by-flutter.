import 'package:flutter/material.dart';

import '../../shared/styles/icon_broken.dart';


class NewPosts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'add posts'
        ),
        leading:  IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon:  Icon(
            IconBroken.Arrow___Left_2,
          ),
        ),
      ),
    );
  }



}
