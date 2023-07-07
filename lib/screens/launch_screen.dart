import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/shared_pref/shared_prefrance.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      bool? flag = SharedPrefController().getData(key: PrefKeys.isLogin.name)??false;
      String routes =  flag?'/home_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, routes);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              Color(0xFF54BAB9),
              Color(0xFF18978F),
            ],
          ),
        ),
        child: Text(
          'DATA APP',
          style: GoogleFonts.nunito(
            fontSize: 18,
            color: const Color(0xFFE9DAC1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
