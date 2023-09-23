import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/modules/chats/chats.dart';
import 'package:social_app/modules/cubit/states.dart';
import 'package:social_app/modules/feeds/feeds.dart';
import 'package:social_app/modules/post/post.dart';
import 'package:social_app/modules/search/search.dart';
import 'package:social_app/modules/setting/setting.dart';
import 'package:social_app/modules/users/users.dart';
import 'package:social_app/shared/componant/constant.dart';

import 'package:firebase_storage/firebase_storage.dart'  as firebase_storage;

import '../../models/message_model.dart';
import '../../shared/network/local/cache_helper.dart';


class SocialCubit extends Cubit<SocialStates>{
  SocialCubit() : super(SocialInitialStates());

  static SocialCubit get(context)=>BlocProvider.of(context);



  SocialUserModel? userModel;
  void getUserData(){
    emit(SocialLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      // print(value.data());
      emit(SocialGetUserSuccess());
    }).catchError((error){
      print(error.toString());
      emit(SocialGetUserError(error.toString()));
    });
  }



  int currentIndex=0;
  List<Widget> screens=[
    SocialFeeds(),
    SocialChats(),
    NewPosts(),
    Socialusers(),
    SocialSetting(),
  ];
  List<String> titles=[
    'Home',
    'Chats ',
    'Post ',
    'Users ',
    'Setting '
  ];
  void changeIndex(int index){
    if(index==1){
      getUsers();
    }
    if(index==2){
      emit(SocialNewPosts());
    }else{
      currentIndex=index;
      emit(SocialChangeBottomNavBar());
    }

  }

//update profile

  File? profileImage;
  var picker=ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      profileImage=File(pickedFile.path);
      emit(SocialProfileImageSuccess());
    }else{
      print('no image selected');
      emit(SocialProfileImageError());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage=File(pickedFile.path);
      emit(SocialCoverImageSuccess());
    }else{
      print('no image selected');
      emit(SocialCoverImageError());
    }
  }



  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileImageSuccess());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImageError());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageError());
    });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadCoverImageSuccess());
        print(value);
        updateUser(name: name, phone: phone, bio: bio,cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImageError());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageError());
    });
  }


//   void updateUserImage({
//    required String name,
//    required String phone,
//    required String bio,
// }) {
//     emit(SocialUserLoadingUpdateError());
//     if (coverImage != null) {
//       uploadCoverImage();
//     } else if (profileImage != null) {
//       uploadProfileImage();
//     } else if(coverImage != null && profileImage != null){
//
//     }
//     else {
//       updateUser(
//           name: name,
//           phone: phone,
//           bio: bio
//       );
//     }
//   }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }){
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      uId: uId,
      image: image??userModel!.image,
      cover: cover??userModel!.cover,
      email: userModel!.email,
      bio: bio,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUserUpdateError());
    });
  }

  //create posts

  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      postImage=File(pickedFile.path);
      emit(SocialPostImageSuccess());
    }else{
      print('no image selected');
      emit(SocialPostImageError());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreateLoadingPost());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(dateTime: dateTime, text: text,postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostSuccess());
      });
    }).catchError((error) {
      emit(SocialCreatePostError());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage
  })
  {
    emit(SocialCreateLoadingPost());

    PostModel model = PostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime:dateTime,
        text: text,
        postImage: postImage
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccess());
    }).catchError((error) {
      emit(SocialCreatePostError());
    });
  }

  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImage());
  }

  //get posts
  List<PostModel> posts=[];
  //post id
  List<String> postId=[];
  //num of likes
  List<int> likes=[];
  //num of comment
  List<int> comment=[];
  void getPosts(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //num of likes
        element.reference
            .collection('likes')
            .get()
            .then((value) {
          element.reference
              .collection('comment')
              .get()
              .then((value) {
            //num of comment
            comment.add(value.docs.length);
            //num of likes
            likes.add(value.docs.length);
            //post id
            postId.add(element.id);
            //get posts
            posts.add(PostModel.fromJson(element.data()));
          })
              .catchError((error){});

        })
            .catchError((error){});

      });
      emit(SocialGetPostsSuccess());
    })
        .catchError((error){
      emit(SocialGetPostsError(error.toString()));
    });
  }

//like
  void likePost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like':true,
    }).then((value) {
      emit(SocialLikePostsSuccess());
    })
        .catchError((error){
      emit(SocialLikePostsError(error.toString()));
    });
  }

  //comment
  void commentPost(String postId){
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(userModel!.uId)
        .set({
      'comment':true,
    }).then((value) {
      emit(SocialCommentPostsSuccess());
    })
        .catchError((error){
      emit(SocialCommentPostsError(error.toString()));
    });
  }

//get all users for chat
  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          // علشان مايجبش اليوزر بتاعي
          if (element.data()['uId'] != userModel!.uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });

        emit(SocialGetAllUserSuccess());
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUserError(error.toString()));
      });
  }

  //chats
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError(error.toString()));
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccess());
    }).catchError((error) {
      emit(SocialSendMessageError(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()     //// عباره عن stream
    // stream => collection of feature مفتوح مش ري الفيوتشر يجيب الداتا مره واحده ويقطع
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(SocialGetMessageSuccess());
    });
  }


// void sendImageMessage({
//   required String photo,
//   required String receiverId,
//   required String dateTime,
//   required String text,
// }){
//   MessageModel model=MessageModel(
//       photo: photo,
//     text: text,
//     dateTime: dateTime,
//     receiverId: receiverId,
//     senderId: userModel!.uId,
//   );
//
//   //set my chat
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(userModel!.uId)
//       .collection('chats')
//       .doc(receiverId)
//       .collection('messages')
//       .add(model.toMap())
//       .then((value) {
//     emit(SocialSendMessageSuccess());
//   })
//       .catchError((error){
//     emit(SocialSendMessageError(error.toString()));
//   });
//
//   //set receiver chat
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(receiverId)
//       .collection('chats')
//       .doc(userModel!.uId)
//       .collection('messages')
//       .add(model.toMap())
//       .then((value) {
//     emit(SocialSendMessageSuccess());
//   })
//       .catchError((error){
//     emit(SocialSendMessageError(error.toString()));
//   });
// }


//get Chat


// File? chatImage;
// Future<void> getChatImage() async
// {
//   final pickedFile=await picker.pickImage(source: ImageSource.gallery);
//   if(pickedFile != null)
//   {
//     chatImage=File(pickedFile.path);
//     emit(SocialChatImageSuccess());
//   }else{
//     print('no image selected');
//     emit(SocialChatImageError());
//   }
// }

}