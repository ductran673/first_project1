import 'package:first_project/app_events.dart';
import 'package:first_project/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBLocs extends Bloc<AppEvents, AppStates>{
  AppBLocs():super(InitStates()){

  print("app bloc");
  on<Increment>((event,serve){
    serve(AppStates(counter: state.counter+1));
    print(state.counter);
  });

  on<Decrement>((event,ask){
    ask(AppStates(counter: state.counter-1));
    print(state.counter);
    });
  }
}