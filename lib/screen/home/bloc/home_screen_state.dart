part of 'home_screen_bloc.dart';

class HomeScreenState extends Equatable {
  final User? user;
  final UserPostResponse? userPostResponse;
  final UserPutResponse? userPutResponse;

  HomeScreenState({
    required this.user,
    required this.userPostResponse,
    required this.userPutResponse,
  });

  HomeScreenState copyWith({
    User? user,
    UserPostResponse? userPostResponse,
    UserPutResponse? userPutResponse,
  }) {
    return HomeScreenState(
      user: user ?? this.user,
      userPostResponse: userPostResponse ?? this.userPostResponse,
      userPutResponse: userPutResponse ?? this.userPutResponse,
    );
  }

  @override
  List<Object?> get props => [user, userPostResponse, userPutResponse];
}
