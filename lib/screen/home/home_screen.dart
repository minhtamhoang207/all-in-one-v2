import 'package:bloc_demo/screen/home/bloc/home_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeScreenBloc(),
      child: BlocHomeScreen(),
    );
  }
}

class BlocHomeScreen extends StatelessWidget {
  const BlocHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Demo'),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (previous, current) => previous.user != current.user,
            builder: (context, state) {
              final user = state.user;
              if (user != null) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(user.data.avatar),
                      SizedBox(height: 8.0),
                      Text(
                        '${user.data.firstName} ${user.data.lastName}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        user.data.email,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ]);
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (previous, current) =>
                previous.userPostResponse != current.userPostResponse,
            builder: (context, state) {
              if (state.userPostResponse != null) {
                return Text('Post at ${state.userPostResponse?.createdAt}');
              } else {
                return Container();
              }
            },
          ),
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            buildWhen: (previous, current) =>
                previous.userPutResponse != current.userPutResponse,
            builder: (context, state) {
              if (state.userPostResponse != null) {
                return Text('Update at ${state.userPutResponse?.updatedAt}');
              } else {
                return Container();
              }
            },
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context.read<HomeScreenBloc>().add(GetEvent());
                },
                child: Text('GET user'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<HomeScreenBloc>().add(PostEvent());
                },
                child: Text('POST user'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<HomeScreenBloc>().add(PutEvent());
                },
                child: Text('PUST user'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
