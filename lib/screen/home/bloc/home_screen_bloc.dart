import 'package:bloc/bloc.dart';
import 'package:bloc_demo/model/user_post_response.dart';
import 'package:bloc_demo/model/user.dart';
import 'package:bloc_demo/model/user_put_response.dart';
import 'package:bloc_demo/repository/home_repository.dart';
import 'package:bloc_demo/request_param/user_param.dart';
import 'package:equatable/equatable.dart';
part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc()
      : super(HomeScreenState(
          user: null,
          userPostResponse: null,
          userPutResponse: null,
        ));

  HomeRepository homeRepository = new HomeRepository();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is GetEvent) {
      yield* _mapGetEventToState();
    } else if (event is PostEvent) {
      yield* _mapPostEventToState(event);
    } else if (event is PutEvent) {
      yield* _mapPutEventToState(event);
    }
    yield state;
  }

  Stream<HomeScreenState> _mapGetEventToState() async* {
    User user;

    try {
      user = await homeRepository.getUser(id: '6');
      yield state.copyWith(user: user);
    } catch (e) {
      print(e);
      yield state.copyWith(user: null);
    }
  }

  Stream<HomeScreenState> _mapPostEventToState(PostEvent event) async* {
    UserPostResponse userPostResponse;

    try {
      userPostResponse = await homeRepository.postUser(
          userParam: UserParam(name: 'QUANg', job: 'coder'));
      yield state.copyWith(userPostResponse: userPostResponse);
    } catch (e) {
      print(e);
      yield state.copyWith(user: null);
    }
  }

  Stream<HomeScreenState> _mapPutEventToState(PutEvent event) async* {
    UserPutResponse userPutResponse;

    try {
      userPutResponse = await homeRepository.putUser(
          userParam: UserParam(name: 'QUANg', job: 'coder'));
      yield state.copyWith(userPutResponse: userPutResponse);
    } catch (e) {
      print(e);
      yield state.copyWith(user: null);
    }
  }
}
