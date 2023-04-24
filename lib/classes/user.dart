import 'package:shared_preferences/shared_preferences.dart';

class UserClass {

  String name;
  String email;
  String username;
  String password;

  UserClass(this.name, this.email, this.username, this.password);
  //Esse construtor obriga que as propriedades sejam definidas ao utilizar a classe

  // User({this.name = "", this.email = "", this.username = "", this.password = ""});
  //Esse construtor deixa opcional

  String userToString() {
    return '$name|$email|$username|$password';
  }

}

class User {

  List<UserClass> registeredUsersList = [];

  static String keyRegisteredUsers = "registeredUsers";

  Future<bool> checkIfThereAreRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? registeredUsers = prefs.getString(keyRegisteredUsers);
    if(registeredUsers == "" || registeredUsers == null){
      return false;
    }else{
      return true;
    }
  }

  //Antes de chamar essa função verificar se o shared preferences está vazio
  addSimulatedUsers() async {

    registeredUsersList.addAll([
      UserClass("Teste", "teste@email.com", "teste", "teste"),
      UserClass("Emily Johnson", "emilyj@email.com", "emilyj82", "p@ssw0rd"),
      UserClass("Daniel Ramirez", "danielr@email.com", "danielr29", "c00lPass"),
      UserClass("Sophie Lee", "sophiel123@email.com", "sophiel123", "1qazxsw2"),
      UserClass("Michael Patel", "michaelpatel@email.com", "mpatel86", "MyPassWord123"),
      UserClass("Julia Wilson", "juliawilson@email.com", "juliawilson23", "s3cur3P@ss"),
      UserClass("Liam Davis", "liamdavis@email.com", "liamdavis98", "P@ssw0rd!")
    ]);

    String usersString = turnListToString(registeredUsersList);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyRegisteredUsers, usersString);

  }

  String turnListToString(List usersList){

    return usersList.map((user) => user.userToString()).join(',');

  }

  List<UserClass> turnStringToList(String usersString){

    return usersString.split(',').map((str) {
      List<String> parts = str.split('|');
      return UserClass(parts[0], parts[1], parts[2], parts[3]);
    }).toList();

  }

  Future<List<UserClass>> getRegisteredUsersList() async {

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsers = prefs.getString(keyRegisteredUsers);
    if(registeredUsers != null && registeredUsers != ""){
      return turnStringToList(registeredUsers);
    }
    return [];

  }

}