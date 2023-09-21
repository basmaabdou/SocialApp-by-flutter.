import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
    required String dataTime,
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
        createPost(dataTime: dataTime, text: text,postImage: value);
      }).catchError((error) {
        emit(SocialCreatePostSuccess());
      });
    }).catchError((error) {
      emit(SocialCreatePostError());
    });
  }

  void createPost({
    required String dataTime,
    required String text,
    String? postImage
  })
  {
    emit(SocialCreateLoadingPost());

    postModel model = postModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime:dataTime,
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
  List<postModel> posts=[];
void getPosts(){
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        posts.add(postModel.fromJson(element.data()));
      });
      emit(SocialGetPostsSuccess());
    }).catchError((error){
      emit(SocialGetPostsError(error.toString()));
    });
}

}