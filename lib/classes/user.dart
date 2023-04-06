import 'package:shared_preferences/shared_preferences.dart';

class User {

  String name;
  String email;
  String username;
  String password;

  User(this.name, this.email, this.username, this.password);
  //Esse construtor obriga que as propriedades sejam definidas ao utilizar a classe

  // User({this.name = "", this.email = "", this.username = "", this.password = ""});
  //Esse construtor deixa opcional

  @override
  String toString() {
    return '$name|$email|$username|$password';
  }

  List<User> registeredUsersList = [];

  String keyRegisteredUsers = "registeredUsers";

  Future<bool> checkIfThereAreRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    String? registeredUsers = prefs.getString(keyRegisteredUsers);
    if(registeredUsers == ""){
      return false;
    }else{
      return true;
    }
  }

  //Antes de chamar essa função verificar se o shared preferences está vazio
  addSimulatedUsers() async {

    registeredUsersList.addAll([
      User("Teste", "teste@email.com", "teste", "teste"),
      User("Emily Johnson", "emilyj@email.com", "emilyj82", "p@ssw0rd"),
      User("Daniel Ramirez", "danielr@email.com", "danielr29", "c00lPass"),
      User("Sophie Lee", "sophiel123@email.com", "sophiel123", "1qazxsw2"),
      User("Michael Patel", "michaelpatel@email.com", "mpatel86", "MyPassWord123"),
      User("Julia Wilson", "juliawilson@email.com", "juliawilson23", "s3cur3P@ss"),
      User("Liam Davis", "liamdavis@email.com", "liamdavis98", "P@ssw0rd!")
    ]);

    String usersString = turnListToString(registeredUsersList);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyRegisteredUsers, usersString);

  }

  String turnListToString(List usersList){

    // String usersString = usersList.map((user) => user.toString()).join(',');
    // return usersString;

    return usersList.map((user) => user.toString()).join(',');

  }

  List turnStringToList(String usersString){

    return usersString.split(',').map((str) {
      List<String> parts = str.split('|');
      return User(parts[0], parts[1], parts[2], parts[3]);
    }).toList();

  }

}