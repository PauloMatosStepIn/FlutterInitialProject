import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/form_submit_button.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/auth_provider.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  //String? email;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  @override
  void dispose(){
    print('dispose called');
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    //print('submit called');
    setState() {
      _submitted = true;
      _isLoading = true;
    }

    //TODO: Print email & password
    //print(email);
    //print('email: ${_emailController.text} : password: ${_passwordController.text}');
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      //await Future.delayed(Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showExceptionAlertDialog(context,
          title: 'Sign In Has Failed',
          exception: e);
      /*showAlertDialog(context,
          title: 'Sign In Failed',
          content: e.message!,
          defaultActionText: 'OK',
          cancelActionText: 'Cancel');
       */
    } finally {
      setState() {
        _isLoading = false;
      }
    }
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    //print('email editing complete');
    //FocusScope.of(context).requestFocus(_passwordFocusNode);
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Have an Account? Sign In';

    //bool submitEnabled = _email.isNotEmpty && _password.isNotEmpty;
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      SizedBox(height: 80.0),
      _buildPasswordTextField(),
      SizedBox(height: 80.0),
      FormSubmitButton(
        text: primaryText,
        //onPressed: submitEnabled ? _submit : null,
        onPressed: _submit,
      ),
      SizedBox(height: 80.0),
      TextButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFormType : null,
      )
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_email);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
          labelText: 'Password',
          errorText: showErrorText ? widget.invalidPasswordErrorText : null,
          enabled: _isLoading ? false : true),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password) => setState,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'test@test.com',
          errorText: showErrorText ? widget.invalidEmailErrorText : null,
          enabled: _isLoading ? false : true),

      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      //onChanged: (value) => email = value,
      onChanged: (email) => setState,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(() {});
  }
}
