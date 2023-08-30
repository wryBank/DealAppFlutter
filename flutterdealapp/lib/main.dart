import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdealapp/pages/app/app_bloc.dart';
import 'package:flutterdealapp/pages/app/app_event.dart';
import 'package:flutterdealapp/pages/app/app_state.dart';
import 'package:flutterdealapp/pages/welcome/bloc/welcome_blocs.dart';
import 'package:flutterdealapp/pages/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(
      create: (context)=> WelcomeBloc(),
      ),
      BlocProvider(
      create: (context)=> AppBloc(),
      )
    ],
    child: ScreenUtilInit(builder: (context, child)=> MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
      routes:{ 
        "MyHomePage":(context)=>const MyHomePage(),}
    )
    
  
    ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key });


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('this is title'),
      ),
      body: Center(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  BlocProvider.of<AppBloc>(context).state.counter.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () 
        {
          BlocProvider.of<AppBloc>(context).add(Increment());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
