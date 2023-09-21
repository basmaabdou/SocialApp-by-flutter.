

abstract class RegisterStates{}

class InitialRegisterSocial extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);

}

class RegisterPasswordChangeState extends RegisterStates{}


class SocialCreateUserSuccessState extends RegisterStates {}

class SocialCreateUserErrorState extends RegisterStates
{
  final String error;

  SocialCreateUserErrorState(this.error);
}


