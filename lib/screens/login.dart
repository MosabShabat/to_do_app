import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared_pref/shared_prefrance.dart';
import '../widgets/app_text_field.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController _emailTextController ;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'login',
          style: GoogleFonts.nunito(
            color: const Color(0xFF18978F),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'login title',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: const Color(0xFF18978F),
              ),
            ),
            Text(
              'login subtitle',
              style: GoogleFonts.nunito(
                height: 0.8,
                fontWeight: FontWeight.w300,
                fontSize: 16,
                color: const Color(0xFF54BAB9),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              textController: _emailTextController,
              hint: 'email',
              prefixIcon: Icons.email,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            AppTextField(
              textController: _passwordTextController,
              hint: 'password',
              prefixIcon: Icons.lock,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (String value) {
              },
            ),
            const SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: AlignmentDirectional.centerStart,
                      end: AlignmentDirectional.centerEnd,
                      colors: [
                        Color(0xFF54BAB9),
                        Color(0xFF18978F),
                      ]),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.black45,
                      blurRadius: 4,
                    )
                  ]),
              child: ElevatedButton(
                onPressed: () => _performLogin(),
                child: Text('login'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 45),
                    shadowColor: Colors.transparent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account',
                  style: GoogleFonts.nunito(),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/register_screen'),
                  child: Text(
                    'Create Now!',
                    style: GoogleFonts.tajawal(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 _performLogin()  {
    if (_checkData()) {
      _login();
    }else {
      showSnackBar(message: 'invalid login');
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(_emailTextController.text)){
        return true;
      }else {
       return false;
      }
    } else {
     return false;
    }
  }

   _login()  async {
     // SharedPrefController shared = SharedPrefController();
     // await shared.getInit();
     SharedPrefController().setData(key: PrefKeys.isLogin.name,value: true);
     SharedPrefController().setData(key: PrefKeys.email.name,value: _emailTextController.text);
     SharedPrefController().setData(key: PrefKeys.password.name,value: _passwordTextController.text);
     Navigator.pushNamed(context, '/home_screen');
  }

  showSnackBar({message,error}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: error ?Colors.red :Colors.green,
    ));
  }
}
