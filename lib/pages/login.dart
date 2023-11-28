import 'package:flutter/material.dart';
import 'package:scheduler/pages/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controllerLoginEmail = TextEditingController();
  final _controllerLoginPassword = TextEditingController();
  
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
                "¡Bienvenido!", 
                style: TextStyle(
                  color: Color.fromRGBO(0, 137, 236, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                "Ingrese sus datos",
                style: TextStyle(
                  color: Color.fromRGBO(0, 137, 236, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
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
                controller: _controllerLoginEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: "Email",
                ),
              ),
              TextField(
                controller: _controllerLoginPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  hintText: "Password",
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {}, 
                child: const Text("Iniciar Sesión"),
              ),
              Column(
                children: [
                  const Text(
                    "¿No tienes una cuenta?",
                    style: TextStyle(
                      color: Color(0xffBABABA),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const RegisterScreen();
                      },
                      ));
                    }, 
                    child: const Text(
                      "Registrese ahora",
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
  
  Widget GoogleOption() {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.grey)
        ),
        child: Image.asset(
          "google.png",
          width: 40,
        ),
      ),
      onTap: () {
        // print("TAP!"); 
      },
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
              const SizedBox(height: 30.0,),
              GoogleOption()
            ],
          ),
        ),
      ),
    );
  }
}