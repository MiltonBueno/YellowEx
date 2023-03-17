import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                padding: EdgeInsets.only(left: size.width * 0.15, right: size.width * 0.15, top: size.height * 0.075),
                child: const Text(
                  "Create your account",
                  style: TextStyle(
                      color: Color(0xff1a2a28),
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                    child: TextFormField(
                      cursorColor: const Color(0xff1a2a28),
                      style: const TextStyle(
                          color: Color(0xff1a2a28)
                      ),
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        labelText: "NAME",
                        labelStyle: TextStyle(
                            color: Color(0xff1a2a28),
                            fontWeight: FontWeight.bold
                        ),
                        hintText: "Example Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                    child: TextFormField(
                      cursorColor: const Color(0xff1a2a28),
                      style: const TextStyle(
                          color: Color(0xff1a2a28)
                      ),
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                            color: Color(0xff1a2a28),
                            fontWeight: FontWeight.bold
                        ),
                        hintText: "example@email.com",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                    child: TextFormField(
                      cursorColor: const Color(0xff1a2a28),
                      style: const TextStyle(
                          color: Color(0xff1a2a28)
                      ),
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        labelText: "USERNAME",
                        labelStyle: TextStyle(
                            color: Color(0xff1a2a28),
                            fontWeight: FontWeight.bold
                        ),
                        hintText: "example_username",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
                child: Container(
                    padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                    child: TextFormField(
                      cursorColor: const Color(0xff1a2a28),
                      style: const TextStyle(
                          color: Color(0xff1a2a28)
                      ),
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.email),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
                        ),
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                            color: Color(0xff1a2a28),
                            fontWeight: FontWeight.bold
                        ),
                        hintText: "example_password",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.075),
                child: Container(
                  width: size.width,
                  // padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                  decoration: BoxDecoration(
                      color: const Color(0xff1a2a28),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "SIGN UP",
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
            ],
          ),
        ),
      ),
    );
  }
}
