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

class SocialUploadCoverImageError extends SocialStates{
}

class SocialUserUpdateLoadingState extends SocialStates{}

class SocialUserUpdateError extends SocialStates{}

