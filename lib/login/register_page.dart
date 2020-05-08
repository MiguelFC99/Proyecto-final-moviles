import 'package:flutter/material.dart';
import 'package:proyecto_app_moviles/home/home_page.dart';
import 'package:proyecto_app_moviles/utils/constants.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _textControllerName = TextEditingController();
  TextEditingController _textControllerEmail = TextEditingController();
  TextEditingController _textControllerPassword = TextEditingController();
  bool _isTextHidden = true, valor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LOGIN_COLOR,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 25.0),
            Column(
              children: <Widget>[
                Image.asset(
                  LOGO_APP,
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  controller: _textControllerName,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff94d500),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff94d500),
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Color(0xff94d500),
                    ),
                    labelText: "Nombre de usuario",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (contenido) {
                    if (contenido.isEmpty) {
                      return "Ingrese nombre";
                    } else {
                      return null;
                    }
                  },
                ),
                 SizedBox(height: 25.0),
                TextFormField(
                  controller: _textControllerEmail,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff94d500),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xff94d500),
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Color(0xff94d500),
                    ),
                    labelText: "Correo",
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (contenido) {
                    if (contenido.isEmpty) {
                      return "Ingrese nombre";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 25.0),

               TextFormField(
      controller: _textControllerPassword,
      obscureText: _isTextHidden,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff94d500),
          ),
        ),
        errorStyle: TextStyle(
          color: Color(0xff94d500),
        ),
        labelText: "Password",
        labelStyle: TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: _isTextHidden
              ? Icon(Icons.visibility_off, color: Colors.white)
              : Icon(Icons.visibility, color: Colors.white),
          onPressed: () {
            setState(() {
              _isTextHidden = !_isTextHidden;
            });
          },
        ),
      ),
      validator: (contenido) {
        if (contenido.isEmpty) {
          return "Ingrese password";
        } else {
          return null;
        }
      },
    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        color: valor ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          valor = !valor;
                        });
                      },
                    ),
                    Text(
                      "Acepto los términos y condiciones",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("REGISTRATE"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "¿Ya tienes cuenta?",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  child: Text(
                    "INGRESA",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: 24.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
