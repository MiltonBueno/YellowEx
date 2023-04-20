import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yellow_exchange/bloc/signup_bloc.dart';

import '../classes/custom_input_decoration.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {

  SignUpBloc signUpBloc = SignUpBloc();

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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1, left: size.width * 0.03, bottom: size.height * 0.015),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff1a2a28),
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.15, right: size.width * 0.15),
                child: Image.asset("assets/logo_extensa_A.png", ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.15, right: size.width * 0.15, top: size.height * 0.055),
                child: const Text(
                  "Create your account",
                  style: TextStyle(
                      color: Color(0xff1a2a28),
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              StreamBuilder<bool>(
                  stream: signUpBloc.errorName.stream,
                  builder: (context, errorName) {
                    return Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.02),
                      child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                          child: TextFormField(
                            controller: signUpBloc.nameController,
                            cursorColor: const Color(0xff1a2a28),
                            style: const TextStyle(
                                color: Color(0xff1a2a28)
                            ),
                            decoration: buildCustomInputDecoration("NAME", "Example Name", errorName.data ?? false),
                          )
                      ),
                    );
                  }
              ),
              StreamBuilder<bool>(
                  stream: signUpBloc.errorEmail.stream,
                  builder: (context, errorEmail) {
                    return Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                      child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                          child: TextFormField(
                            controller: signUpBloc.emailController,
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
                  stream: signUpBloc.errorUsername.stream,
                  builder: (context, errorUsername) {
                    return Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                      child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                          child: TextFormField(
                            controller: signUpBloc.usernameController,
                            cursorColor: const Color(0xff1a2a28),
                            style: const TextStyle(
                                color: Color(0xff1a2a28)
                            ),
                            decoration: buildCustomInputDecoration("USERNAME", "example_username", errorUsername.data ?? false),
                          )
                      ),
                    );
                  }
              ),
              StreamBuilder<bool>(
                  stream: signUpBloc.errorPassword.stream,
                  builder: (context, errorPassword) {
                    return Padding(
                      padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                      child: Container(
                          padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                          child: StreamBuilder<bool>(
                              stream: signUpBloc.passwordObscure.stream,
                              initialData: true,
                              builder: (context, obscure) {
                                return TextFormField(
                                  obscureText: obscure.data ?? true,
                                  controller: signUpBloc.passwordController,
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
                                        signUpBloc.passwordObscure.sink.add(!obscure.data!);
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
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.07),
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
                        stream: signUpBloc.loadingSignUp.stream,
                        builder: (context, snapshot) {

                          bool loading = snapshot.data ?? false; //Intermediate variable to avoid possible null value

                          return TextButton(
                            child: loading ?
                            const SizedBox(
                                height: 30, width: 30,
                                child: CircularProgressIndicator(color: Colors.white,))
                                : const Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),
                            ),
                            onPressed: () {
                              signUpBloc.addNewUser();
                            },
                          );
                        }
                    )
                ),
              ),
              StreamBuilder<String>(
                  stream: signUpBloc.errorMessage.stream,
                  builder: (context, message) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.03),
                      child: Text(
                        message.data ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: message.data != null ? errorColor : Colors.transparent,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
