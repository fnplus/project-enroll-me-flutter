import 'package:enroll_me/app/services/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailSignUpPage extends StatefulWidget {
  @override
  _EmailSignUpPageState createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _repass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("EMAIL SIGN UP",
            style: TextStyle(
              color: Color(0xFF424b54),
              letterSpacing: 5,
              fontSize: 25,
            )),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            DataField(
              heading: 'Name',
              icon: Icons.perm_identity,
              controller: _name,
            ),
            DataField(
              heading: 'Email',
              icon: Icons.email,
              controller: _email,
            ),
            DataField(
              heading: 'Password',
              icon: Icons.vpn_key,
              controller: _pass,
            ),
            DataField(
              heading: 'Retype Password',
              icon: Icons.vpn_key,
              controller: _repass,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                onPressed: () async {
                  print("Name received: " + _name.text);
                  print("Email received: " + _email.text);
                  print("Pass: " + _pass.text);
                  print("Re-Pass: " + _repass.text);

                  if (_pass.text.compareTo(_repass.text) == 0) {
                    print("you may proceed");
                    await authService.signUpWithEmail(
                        _name.text, _email.text, _pass.text);
                  } else {
                    //TODO: Handle the passwords not match case
                    print("Both passwords do not match");
                  }
                },
                elevation: 3,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xFF401f3e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataField extends StatelessWidget {
  final String heading;
  final IconData icon;
  final TextEditingController controller;

  const DataField({Key key, this.heading, this.icon, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: heading.contains("Password") ? true : false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              gapPadding: 20,
              borderSide: BorderSide(
                color: Color(0xFF401f3e),
              ),
              borderRadius: BorderRadius.circular(20)),
          labelText: heading,
          labelStyle: TextStyle(color: Color(0xFF401f3e), fontSize: 18),
          alignLabelWithHint: true,
          prefixIcon: Icon(
            icon,
            color: Color(0xFF401f3e),
          ),
          border: OutlineInputBorder(
            gapPadding: 20,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
