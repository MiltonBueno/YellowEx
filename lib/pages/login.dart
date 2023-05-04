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
              StreamBuilder<bool>(
                stream: loginBloc.errorEmail.stream,
                builder: (context, errorEmail) {
                  return Padding(
                    padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                    child: Container(
                      padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                      child: TextFormField(
                        controller: loginBloc.emailController,
                        cursorColor: const Color(0xff1a2a28),
                        style: const TextStyle(
                          color: Color(0xff1a2a28)
                        ),
                        decoration: buildCustomInputDecoration("EMAIL", "example@email.com", errorEmail.data ?? false),
                      )
                    ),
                  );
                }
              ),
              StreamBuilder<bool>(
                stream: loginBloc.errorPassword.stream,
                builder: (context, errorPassword) {
                  return Padding(
                    padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                    child: Container(
                      padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                      child: StreamBuilder<bool>(
                        stream: loginBloc.passwordObscure.stream,
                        initialData: true,
                        builder: (context, obscure) {
                          return TextFormField(
                            obscureText: obscure.data ?? true,
                            controller: loginBloc.passwordController,
                            cursorColor: const Color(0xff1a2a28),
                            style: const TextStyle(
                              color: Color(0xff1a2a28)
                            ),
                            decoration: InputDecoration(
                              // icon: Icon(Icons.email),
                              disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                (errorPassword.data ?? false) ? errorColor : const Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                (errorPassword.data ?? false) ? errorColor : const Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                (errorPassword.data ?? false) ? errorColor : const Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                (errorPassword.data ?? false) ? errorColor : const Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              labelText: "PASSWORD",
                              labelStyle: TextStyle(
                                color: (errorPassword.data ?? false) ? errorColor : const Color(0xff1a2a28),
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "example_password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: obscure.data != null && obscure.data! ? const Icon(Icons.visibility_off, color: Colors.grey,) : const Icon(Icons.visibility, color: Colors.grey),
                                onPressed: (){
                                  loginBloc.passwordObscure.sink.add(!obscure.data!);
                                },
                              ),
                            ),
                          );
                        }
                      )
                    ),
                  );
                }
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
                    child: StreamBuilder<bool>(
                        initialData: false,
                        stream: loginBloc.loadingLogin.stream,
                        builder: (context, snapshot) {

                          bool loading = snapshot.data ?? false; //Intermediate variable to avoid possible null value

                          return TextButton(
                            child: loading ?
                            const SizedBox(
                                height: 30, width: 30,
                                child: CircularProgressIndicator(color: Colors.white,))
                             : const Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),
                            ),
                            onPressed: () {
                              loginBloc.validateLogin(context);
                            },
                          );
                        }
                    )
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
              StreamBuilder<String>(
                stream: loginBloc.errorMessage.stream,
                builder: (context, message) {
                  return Text(
                    message.data ?? "",
                    style: TextStyle(
                      color: message.data != null ? errorColor : Colors.transparent,
                      fontSize: 15,
                    ),
                  );
                }
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.025),
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
