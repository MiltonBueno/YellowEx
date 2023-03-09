import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 600;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.15, right: size.width * 0.15, top: size.height * 0.35),
              child: Image.asset("assets/logo_extensa_A.png", ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.1),
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: userController,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    hintText: "Usuário",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 20
                    ),
                    icon: const Icon(Icons.person, size: 35,),
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.grey,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 20
                    ),
                    icon: const Icon(Icons.lock, size: 30,),
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03),
              child: Container(
                padding: EdgeInsets.only(left: size.width * 0.015, right: size.width * 0.015),
                child: TextFormField(
                  decoration: const InputDecoration(
                    // icon: Icon(Icons.email),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    hintText: "exemplo@email.com",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    // labelText: "widget.labelText",
                    // labelStyle: TextStyle(
                    //   color: Colors.blueAccent,
                    // ),
                  ),
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05, top: size.height * 0.03, bottom: size.height * 0.1),
              child: Container(
                  width: size.width,
                  padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "ENTRAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
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
            )
          ],
        ),
      ),
    );
  }
}
