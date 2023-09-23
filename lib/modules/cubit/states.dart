abstract class SocialStates{}

class SocialInitialStates extends SocialStates{}

class SocialLoadingStates extends SocialStates{}

class SocialGetUserSuccess extends SocialStates{}

class SocialGetUserError extends SocialStates{
  final String error;

  SocialGetUserError(this.error);
}


class SocialChangeBottomNavBar extends SocialStates{}

class SocialNewPosts extends SocialStates{}

class SocialProfileImageSuccess extends SocialStates{}

class SocialProfileImageError extends SocialStates{}

class SocialCoverImageSuccess extends SocialStates{}

class SocialCoverImageError extends SocialStates{}

class SocialUploadProfileImageSuccess extends SocialStates{}

class SocialUploadProfileImageError extends SocialStates{}

class SocialUploadCoverImageSuccess extends SocialStates{}

class SocialUploadCoverImageError extends SocialStates{}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateError extends SocialStates{}

//create posts
class SocialCreateLoadingPost extends SocialStates{}

class SocialCreatePostSuccess extends SocialStates{}

class SocialCreatePostError extends SocialStates{}

class SocialPostImageSuccess extends SocialStates{}

class SocialPostImageError extends SocialStates{}

class SocialRemovePostImage extends SocialStates{}

//get posts
class SocialGetPostsSuccess extends SocialStates{}

class SocialGetPostsError extends SocialStates{
  final String error;

  SocialGetPostsError(this.error);

}

//like posts
class SocialLikePostsSuccess extends SocialStates{}

class SocialLikePostsError extends SocialStates{
  final String error;

  SocialLikePostsError(this.error);

}

//comment posts
class SocialCommentPostsSuccess extends SocialStates{}

class SocialCommentPostsError extends SocialStates{
  final String error;

  SocialCommentPostsError(this.error);

}

//get all users for chat
class SocialGetAllUserSuccess extends SocialStates{}

class SocialGetAllUserError extends SocialStates{
  final String error;

  SocialGetAllUserError(this.error);
}

//chat
class SocialSendMessageSuccess extends SocialStates{}

class SocialSendMessageError extends SocialStates{
  final String error;

  SocialSendMessageError(this.error);
}

class SocialGetMessageSuccess extends SocialStates{}

class SocialGetMessageError extends SocialStates{
  final String error;

  SocialGetMessageError(this.error);
}

class SocialChatImageSuccess extends SocialStates{}

class SocialChatImageError extends SocialStates{}