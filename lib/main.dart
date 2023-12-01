import 'package:first_project/app_blocs.dart';
import 'package:first_project/app_events.dart';
import 'package:first_project/app_states.dart';
import 'package:first_project/pages/sign_in/bloc/sign_in_blocs.dart';
import 'package:first_project/pages/sign_in/sign_in.dart';
import 'package:first_project/pages/welcome/bloc/welcome_blocs.dart';
import 'package:first_project/pages/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  //options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const MyApp());
}

// void main() {
//   runApp(MaterialApp(
//     home: SafeArea(
//       child:Scaffold(
//         body: Center(child: MyWidget2(false)),
//         // appBar:AppBar(
//         //   backgroundColor: Colors.blueAccent,
//         //   title: const Text('Tự học Flutter'),
//         // ),
//         // body: const Center(
//         //   child: Text('Hello World'),
//         //
//         // )
//       ),
//     ),
//     debugShowCheckedModeBanner: false,
//   ));
//
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
         providers: [
           BlocProvider(
           create:  (context) => WelcomeBloc()
           ),
           BlocProvider(
               create:  (context) => AppBLocs()
           ),
           BlocProvider(create: (context)=>SignInBloc())
         ],
         child : ScreenUtilInit(
           builder : (context, child) => MaterialApp(
             debugShowCheckedModeBanner: false,

             home:  const Welcome(),
            routes: {
               "myHomePage": (context) => const MyHomePage(),
              "signIn": (context)=> const SignIn(),

            },
           )
         ),
    );
  }
}


class MyWidget extends StatelessWidget{

  final bool loading;
  MyWidget(this.loading);

  @override
  Widget build(BuildContext context) {
    // if(loading){
    //   return const CircularProgressIndicator();
    // }
    // else {
    //   return const Text('State');
    // }
    return loading ? const CircularProgressIndicator() : const Text('State');
  }

}
class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang Chủ"),
      ),
      body: Center(
        child: BlocBuilder<AppBLocs, AppStates>(
          builder: (context, state ){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Bạn đã nhấn nút này nhiều lần!!!"
                ),
                Text(
                  "${BlocProvider.of<AppBLocs>(context).state.counter}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        )
      ),
      floatingActionButton: Row(
        mainAxisAlignment:  MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            heroTag: "1heroTag1",
              onPressed: ()=>BlocProvider.of<AppBLocs>(context).add(Increment()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),

          ),
          FloatingActionButton(
            heroTag: "1heroTag2",
            onPressed: ()=>BlocProvider.of<AppBLocs>(context).add(Decrement()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),

          ),
        ],

      ),
    );

  }

}

class MyWidget2 extends StatefulWidget{
  final bool loading;

  MyWidget2(this.loading);

  @override
  State<StatefulWidget> createState() {
    return MyWidget2State();
  }

}

class MyWidget2State extends State<MyWidget2>{
  late bool _localLoading;
  @override
  void initState() {
    _localLoading = widget.loading;

  }

  @override
  Widget build(BuildContext context) {
    return _localLoading ? const CircularProgressIndicator() : FloatingActionButton(onPressed: onClickButton);
  }
 void onClickButton(){
    setState(() {
      _localLoading = true;
    });
 }
}
