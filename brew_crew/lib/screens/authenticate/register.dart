import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email='';
  String password  = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return loading ==true?Loading():
    Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          FlatButton.icon(
            icon:Icon(Icons.person),
            label: Text('Sign in'),
            onPressed: ()=>widget.toggleView(),
          ),
        ],
      ),

      body: Container(
          padding: EdgeInsets.symmetric(
              vertical:20.0,horizontal:50),

          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val)=>val.isEmpty? 'Enter an email':null,
                    onChanged: (value) {
                      email = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val)=>val.length<6?'Enter a password 6+ chars long':null,
                    onChanged: (value) {
                      password = value;
                      setState(() {});
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20,),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: ()async{
                      if(_formKey.currentState.validate()) {
                        setState(()=>loading = true);
                        dynamic res = await _auth.registerWithEmailAndPassword(email, password);
                        if(res==null) {
                          error = "Please enter valid email";
                          loading = false;
                          setState(() {});
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(
                      color:Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
