import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto_app_moviles/acerca/bloc/acerca_bloc.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  AcercaBloc acerBloc;

  @override
  void dispose() {
    acerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          acerBloc = AcercaBloc();
          return acerBloc;
        },
        child: BlocListener<AcercaBloc, AcercaState>(
            listener: (context, state) {},
            child: BlocBuilder<AcercaBloc, AcercaState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: PRIMARY_COLOR,
                  appBar: AppBar(
                    backgroundColor: BAR_COLOR,
                    title: Text(SETTINGS_TITLE,style: TextStyle(color: COLOR_WHI),),
                    actions: <Widget>[],
                  ),
                  body: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 70,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      PROFILE_PICTURE,
                                    ),
                                    minRadius: 40,
                                    maxRadius: 40,
                                  ),
                                ),
                                Text(PROFILE_NAME),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(PROFILE_EMAIL),
                            SizedBox(
                              height: 16,
                            ),
                            ListTile(
                              title: Text("privacidad"),
                              leading: Icon(Icons.vpn_key),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text("Chats"),
                              leading: Icon(Icons.chat),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text("Notificaciones"),
                              leading: Icon(Icons.notifications),
                              onTap: () {},
                            ),
                            ListTile(
                              title: Text("Datos y almacenamiento"),
                              leading: Icon(Icons.data_usage),
                              onTap: () {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Si desea informar sobre algun problema o dar una sugerencia envienos su comentario"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    color: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.envelope,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Contactar",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      acerBloc.add(EviarEvent());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        /*Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Text(PROFILE_LOGOUT),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),*/
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}