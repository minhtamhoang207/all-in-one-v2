import 'package:bloc/bloc.dart';
import 'package:bloc_demo/model/Coffee/coffee.dart';
import 'package:bloc_demo/repository/coffee_repository.dart';
part 'coffee_screen_event.dart';
part 'coffee_screen_state.dart';


class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  CoffeeBloc() : super(CoffeeState());

  CoffeeRepository coffeeRepository = new CoffeeRepository();

  @override
  Stream<CoffeeState> mapEventToState(CoffeeEvent event) async* {
    if(event is GetEvent){
      yield(Loading());
      print("Loading");
      List<Coffee> coffees;
      try {
        coffees = await coffeeRepository.getCoffees(type: "iced");
        yield Success(coffees: coffees);
      } catch (e) {
        print(e);
        print("errrrrr--------------------------");
        yield LoadFailed(e.toString());
      }
    }
  }
}
