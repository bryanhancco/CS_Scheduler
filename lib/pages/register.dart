import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/pages/login.dart';
//import 'package:syncfusion_flutter_calendar/calendar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controllerRegisterEmail = TextEditingController();
  final _controllerRegisterPassword = TextEditingController();
  final _controllerRegisterConfirmPassword = TextEditingController();

  Widget Presentation() {
    MediaQueryData queryData = MediaQuery.of(context);
    return SizedBox(
      width: queryData.size.width * 0.9,
      child: const Card(
        elevation: 16,
        shadowColor: Colors.black,
        color: Color(0xffF0F0F0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Crea tu Cuenta!", 
                style: TextStyle(
                  color: Color.fromRGBO(0, 137, 236, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget SignInBody() {
    MediaQueryData queryData = MediaQuery.of(context);
    return SizedBox(
      width: queryData.size.width * 0.9,
      child: Card(
        elevation: 16,
        shadowColor: Colors.black,
        color: const Color(0xffF0F0F0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _controllerRegisterEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: _controllerRegisterPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              TextField(
                controller: _controllerRegisterConfirmPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: "Confirm Password",
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {}, 
                child: const Text("Registrar"),
              ),
              Column(
                children: [
                  const Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                      color: Color(0xffBABABA),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                      ));
                    }, 
                    child: const Text(
                      "Iniciar sesión",
                      style: TextStyle(
                        color: Color(0xff0089EC),
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ),
                ],
              )
            ].map((widget) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget,
              ))
            .toList(),               
          ),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("background_login.png"),
            fit: BoxFit.cover,
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Presentation(),
              const SizedBox(height: 30.0,),
              SignInBody(),
            ],
          ),
        ),
      ),
    );
  }
}