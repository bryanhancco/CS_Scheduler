import 'package:flutter/material.dart';
import 'package:scheduler/pages/home.dart';
import 'package:scheduler/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _controllerRegisterEmail = TextEditingController();
  final _controllerRegisterPassword = TextEditingController();
  final _controllerRegisterConfirmPassword = TextEditingController();
  
  void wrongCredentials() {
    showDialog(
      context: context, 
      builder:(context) {
        return const AlertDialog(
          title: Center(child: Text("Verifique correctamente los datos")),
        );
      },
    );
  }

  void signUserUp() async {
    showDialog(
      context: context, 
      builder:(context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (_controllerRegisterPassword.text == _controllerRegisterConfirmPassword.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerRegisterEmail.text, 
          password: _controllerRegisterPassword.text,      
        );
      } else {
        wrongCredentials();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongCredentials();
    }
  }

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
  Widget RegisterBody() {
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
                onPressed: signUserUp,
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
                    onPressed: widget.onTap,
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
              RegisterBody(),
            ],
          ),
        ),
      ),
    );
  }
}