import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/main_screen.dart';
import '../../providers/user_provider.dart';
import '../../providers/order_provider.dart';
import '../../models/order.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  String errMsg = "";

  //TextEditingController _emailController = TextEditingController();
  //TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Order ords = Provider.of<Order>(context);
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            //---User Name---
            usernameLogin(),

            SizedBox(height: 10),

            //---Password---
            passwordLogin(),

            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  bool passValidate = _formKey.currentState.validate();
                  if (passValidate) {
                    User().signIn(username, password);
                    //print(statusCode);

                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    Future.delayed(Duration(seconds: 1), () {
                      if ((prefs.getInt('userId')) != null) {
                        ords.loadOrderbyId();
                        errMsg = "";
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                            (route) => false);
                      } else {
                        errMsg = "Wrong password !!";
                      }
                    });
                  } else {
                    errMsg = "";
                  }
                },
              ),
            ),
            SizedBox(height: 15),
            Container(
              child: Text(
                errMsg,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  
  void keepUser() async {
    
   final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', 1);
    prefs.setString('username', username);
    prefs.setString('token', password); 
  }
*/
  TextFormField usernameLogin() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onChanged: (newValue) => username = newValue,
      //controller: _emailController,
      validator: (String inputUsername) {
        if (inputUsername.isEmpty) {
          return "Please input username.";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.person,
          color: Colors.grey[700],
          size: 20.0,
        ),
      ),
    );
  }

  TextFormField passwordLogin() {
    return TextFormField(
      obscureText: true,
      //controller: _passwordController,
      validator: (String inputPassword) {
        if (inputPassword.isEmpty) {
          return "Please input password";
        } else {
          return null;
        }
      },
      onChanged: (newValue) => password = newValue,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(
          Icons.lock,
          color: Colors.grey[700],
          size: 20.0,
        ),
      ),
    );
  }
}
