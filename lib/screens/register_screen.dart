import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/shared_pref/shared_prefrance.dart';
import 'package:to_do_app/widgets/app_text_form_field.dart';

import '../model/user.dart';
import '../widgets/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  var formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF18978F)),
        title: Text(
          'register',
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'register title',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: const Color(0xFF18978F),
                ),
              ),
              Text(
               'register subtitle',
                style: GoogleFonts.nunito(
                  height: 0.8,
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: const Color(0xFF54BAB9),
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                textController: _nameTextController,
                hint: 'name',
                prefixIcon: Icons.person,
                textInputType: TextInputType.text,
                validatte: (value){
                  if(value!.isEmpty){
                    return 'fill name felid';
                  }else if(value.split(" ").length < 3){
                    return 'enter full name';
                  }
                  return null;
                },

              ),
              const SizedBox(height: 10),
              AppTextFormField(
                textController: _emailTextController,
                hint: 'email',
                prefixIcon: Icons.email,
                textInputType: TextInputType.emailAddress,
                validatte: (value){
                  if(value!.isEmpty){
                    return 'fill email field';
                  }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailTextController.text)){
                    return 'write correct email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              AppTextFormField(
                textController: _passwordTextController,
                hint: 'password',
                prefixIcon: Icons.lock,
                obscureText: true,
                textInputAction: TextInputAction.done,
                validatte: (value){
                  if(value!.isEmpty){
                    return 'fill password felid';
                  }else if(value.length<6){
                    return 'your password must been more than  6 digit ';
                  }
                  return null;
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
                  onPressed: () async => await _performRegister(),
                  child: Text('register'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performRegister() async {
    if (formKey.currentState!.validate()) {
      await _register();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> _register() async {
    SharedPrefController().saveUser(user: user);
   Navigator.pushNamed(context, '/home_screen');
   }

  User get user {
    User user = User();
    user.name = _nameTextController.text;
    user.email = _emailTextController.text;
    user.password = _passwordTextController.text;
    return user;
  }
}
