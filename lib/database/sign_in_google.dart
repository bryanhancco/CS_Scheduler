import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    // inicia el proceso de inicio de sesión
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // se obtienen los detalles del pedido de autenticación
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    // se crea una nueva credencial para el usuario
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}