part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {}

class SplashIsUser extends SplashState {
  String userId;
  SplashIsUser({required this.userId});

  @override
  List<Object> get props => [this.userId];
}

class SplashIsGuest extends SplashState {}


