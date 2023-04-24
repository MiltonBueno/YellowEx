import 'package:flutter/material.dart';
import '../bloc/forgot_password_bloc.dart';

class ForgotPassword2 extends StatefulWidget {

  final String email;

  const ForgotPassword2({Key? key, required this.email}) : super(key: key);

  @override
  State<ForgotPassword2> createState() {
    return _ForgotPassword2State();
  }

}

class _ForgotPassword2State extends State<ForgotPassword2> {

  ForgotPasswordBloc forgotPasswordBloc = ForgotPasswordBloc();

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
                    padding: EdgeInsets.only(top: size.height * 0.1, left: size.width * 0.03),
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
                padding: EdgeInsets.only(left: size.width * 0.225, right: size.width * 0.225),
                child: Image.asset("assets/forgot_password.png", ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.15, right: size.width * 0.15, top: size.height * 0.05),
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(
                      color: Color(0xff1a2a28),
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1, top: size.height * 0.01),
                child: const Text(
                  "Since this is an app for tests, there isn't a real way of resetting your password through your email "
                  "so if you want to define a new password just type and click in the button",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff1a2a28),
                    fontSize: 16,
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.02),
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                    child: StreamBuilder<bool>(
                        stream: forgotPasswordBloc.passwordObscure.stream,
                        initialData: true,
                        builder: (context, obscure) {
                          return TextFormField(
                            obscureText: obscure.data ?? true,
                            controller: forgotPasswordBloc.passwordController,
                            cursorColor: const Color(0xff1a2a28),
                            style: const TextStyle(
                                color: Color(0xff1a2a28)
                            ),
                            decoration: InputDecoration(
                              // icon: Icon(Icons.email),
                              disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color:
                                Color(0xff1a2a28),
                                    width: 1.5),
                              ),
                              labelText: "PASSWORD",
                              labelStyle: const TextStyle(
                                color: Color(0xff1a2a28),
                                fontWeight: FontWeight.bold,
                              ),
                              hintText: "example_password",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: obscure.data != null && obscure.data! ? const Icon(Icons.visibility_off, color: Colors.grey,) : const Icon(Icons.visibility, color: Colors.grey),
                                onPressed: (){
                                  forgotPasswordBloc.passwordObscure.sink.add(!obscure.data!);
                                },
                              ),
                            ),
                          );
                        }
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.06),
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
                        stream: forgotPasswordBloc.loadingReset2.stream,
                        builder: (context, snapshot) {

                          bool loading = snapshot.data ?? false; //Intermediate variable to avoid possible null value

                          return TextButton(
                            child: loading ?
                            const SizedBox(
                                height: 30, width: 30,
                                child: CircularProgressIndicator(color: Colors.white,))
                                : const Text(
                              "DEFINE NEW PASSWORD",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ),
                            ),
                            onPressed: () {
                              forgotPasswordBloc.defineNewPassword(widget.email);
                            },
                          );
                        }
                    )
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.025),
              //   child: StreamBuilder<String>(
              //       stream: forgotPasswordBloc.errorMessage.stream,
              //       builder: (context, message) {
              //         return Text(
              //           message.data ?? "",
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: message.data != null ? errorColor : Colors.transparent,
              //             fontSize: 15,
              //           ),
              //         );
              //       }
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
