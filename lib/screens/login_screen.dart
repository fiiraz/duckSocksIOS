import 'package:flutter/material.dart';
import 'package:simplefire/helpers/validators.dart';
import 'package:simplefire/presenters/login_presenter.dart';
import 'package:validate/validate.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPresenter presenter;

  @override
  void initState() {
    super.initState();

    presenter = new LoginPresenter(this);
    presenter.isLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // TODO: Remove here after development
        presenter.currentStaff.email = "aykut@apoblo.com";
        presenter.currentStaff.password = "12345678";
        _emailController.text = presenter.currentStaff.email;
        _passwordController.text = presenter.currentStaff.password;
      }
    });
  }

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return presenter.applicationScreen.widgetWithHud(
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/logo_sm.png', width: MediaQuery.of(context).size.width/1),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 29.0),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                autocorrect: false,
                controller: _emailController,
                onSaved: (val) {
                  presenter.currentStaff.email = val;
                },
                keyboardType: TextInputType.emailAddress,
                validator: (val) =>
                    CustomValidators.validate(val, Validate.isEmail),
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
                onSaved: (val) {
                  presenter.currentStaff.password = val;
                },
                validator: (val) =>
                    CustomValidators.validate(val, Validate.isPassword),
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Signup'),
                    onPressed: () {
                      presenter.signupButtonClicked();
                    },
                  ),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () {
                      presenter.loginButtonClicked();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      footBar: false,
      appBar: false,
    );
  }
}
