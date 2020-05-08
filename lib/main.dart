import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_app_moviles/documentos/receive_doc.dart';
import 'package:proyecto_app_moviles/imagenes/receive_image.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
//import 'package:hive/hive.dart';
//import 'package:path_provider/path_provider.dart' as path_provider;

import 'authentication/authentication_bloc/authentication_bloc.dart';
import 'home/home_page.dart';
import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc()..add(VerifyAuthenticatedUser()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription _intentDataStreamSubscription;
  List<SharedMediaFile> _sharedFiles;
  String _sharedText;

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        print("Shared:" + (_sharedFiles?.map((f) => f.path)?.join(",") ?? ""));
      });
    });

    /* For sharing or opening urls/text coming from outside the app while the app is in the memory
    _intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    }, onError: (err) {
      print("getLinkStream error: $err");
    });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String value) {
      setState(() {
        _sharedText = value;
        print("Shared: $_sharedText");
      });
    });*/
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Proyecto moviles",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (_sharedFiles != null) {
            String prueba = _sharedFiles?.map((f) => f.path)?.join(",") ?? "";
            String temp = (prueba[prueba.length - 3] +
                    prueba[prueba.length - 2] +
                    prueba[prueba.length - 1])
                .toLowerCase();
            print("$temp");
            if (temp == "jpg" || temp == "png" || temp == "peg") {
              return ReceiveImagenApp(
                  intentDataStreamSubscription: _intentDataStreamSubscription,
                  sharedFiles: _sharedFiles,
                  sharedText: _sharedText);
            } else {
              return ReceiveDocApp(
                intentDataStreamSubscription: _intentDataStreamSubscription,
                sharedFiles: _sharedFiles,
                sharedText: _sharedText);
              
            }
          }

          if (state is AuthenticatedSuccessfully) return HomePage();
          if (state is UnAuthenticated) return LoginPage();
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
