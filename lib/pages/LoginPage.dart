import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/LoginController.dart';
import 'package:todo/pages/HomePage.dart';
import 'package:todo/service/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _userLoginFormKey = GlobalKey();

  bool isSignIn = false;
  bool google = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthMethods>();
    var deviceSize = MediaQuery.of(context).size;
    final value = context.watch<LoginController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: deviceSize.height / 1.65,
              width: deviceSize.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: deviceSize.height / 2,
                  width: deviceSize.width / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splashlogo.png'),
                    ),
                  ),
                ),
                Form(
                  key: _userLoginFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, bottom: 15, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, right: 14, left: 14, bottom: 8),
                            child: TextFormField(
                              enabled: false,
                              controller: _userIdController,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 15),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, right: 14, left: 14, bottom: 8),
                            child: TextFormField(
                              enabled: false,
                              controller: _passwordController,
                              obscureText: value.passwordVisible,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                hintText: "Password",
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 15.0, 20.0, 15.0),
                                hintStyle: const TextStyle(fontSize: 15),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      value.passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFFE6E6E6),
                                    ),
                                    onPressed: () {
                                      value.passwordVisible =
                                          !value.passwordVisible;
                                    }),
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            child: Container(
                                width: deviceSize.width / 2,
                                height: deviceSize.height / 18,
                                margin: const EdgeInsets.only(top: 25),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage('assets/google.jpg'),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const Text(
                                      'Sign in with Google',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ))),
                            onTap: () async {
                              await auth
                                  .signInWithGoogle(context)
                                  .whenComplete(() {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()),
                                    (route) => false);
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
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

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _userIdController.dispose();
  }
}
