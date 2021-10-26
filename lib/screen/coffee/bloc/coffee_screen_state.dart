part of 'coffee_screen_bloc.dart';

class CoffeeState{}

class Loading extends CoffeeState {}

class Success extends CoffeeState {
  List<Coffee> coffees = [];
  Success({required this.coffees});
}

class LoadFailed extends CoffeeState {
  String message;
  LoadFailed(this.message);
}