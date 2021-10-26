import 'package:bloc_demo/screen/coffee/bloc/coffee_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeScreen extends StatefulWidget {
  CoffeeScreen({Key? key}) : super(key: key);

  @override
  _CoffeeScreenState createState() => _CoffeeScreenState();
}

class _CoffeeScreenState extends State<CoffeeScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoffeeBloc()..add(GetEvent()),
      child: BlocCoffeeHomeScreen(),
    );
  }
}

class BlocCoffeeHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Demo'),
      ),
      body: BlocBuilder<CoffeeBloc, CoffeeState>(
        builder: (context, state){
          if (state is Success){
            print("Success");
            print("---------------------------------");
            print(state.coffees[0]);
            return ListView.builder(
                itemCount: state.coffees.length,
                itemBuilder: (context, index){
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFb2b8a3)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.coffees[index].title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${state.coffees[index].description}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black45
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
          if (state is LoadFailed ){
            return Center(
              child: Text("${state.message}", style: TextStyle(
                color: Colors.red
              )),
            );
          }
          if(state is Loading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}

