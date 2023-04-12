import 'package:flutter/material.dart';
import 'package:yellow_exchange/bloc/login_bloc.dart';

import '../classes/custom_input_decoration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  LoginBloc loginBloc = LoginBloc();

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      loginBloc.checkRegisteredUsers(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login_transparent.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.25, right: size.width * 0.25, top: size.height * 0.25),
                child: Image.asset("assets/logo_simplificada.png", ),
                // child: Image.asset("assets/logo_extensa_A.png", ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                  padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                  child: TextFormField(
                    controller: loginBloc.emailController,
                    cursorColor: const Color(0xff1a2a28),
                    style: const TextStyle(
                      color: Color(0xff1a2a28)
                    ),
                    decoration: buildCustomInputDecoration("USERNAME", "example@email.com"),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                  padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                  child: TextFormField(
                    controller: loginBloc.passwordController,
                    cursorColor: const Color(0xff1a2a28),
                    style: const TextStyle(
                      color: Color(0xff1a2a28)
                    ),
                    decoration: buildCustomInputDecoration("PASSWORD", "example"),
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.05),
                child: Container(
                    width: size.width,
                    height: 47.5,
                    // padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                    decoration: BoxDecoration(
                        color: const Color(0xff1a2a28),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextButton(
                      onPressed: () {
                        loginBloc.validateLogin();
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17
                        ),
                      )
                    ),
                    // child: StreamBuilder<bool>(
                    //     initialData: false,
                    //     stream: _loadingButton.stream,
                    //     builder: (context, loading) {
                    //       return TextButton(
                    //         child: !loading.data! ?
                    //         const Text(
                    //           "ENTRAR",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: 15
                    //           ),
                    //         ) : const SizedBox(
                    //             height: 30, width: 30,
                    //             child: CircularProgressIndicator(color: Colors.white,)),
                    //         onPressed: () async {
                    //         },
                    //       );
                    //     }
                    // )
                ),
              ),
              TextButton(
                onPressed: () {
                  loginBloc.goToForgotPasswordPage(context);
                  // loginBloc.deleteSimulatedUsers();
                },
                child: const Text(
                  "Forgot my password",
                  style: TextStyle(
                    color: Color(0xff1a2a28),
                    fontSize: 15,
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: TextButton(
                  onPressed: () {
                    loginBloc.goToSignUpPage(context);
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Color(0xff1a2a28),
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
