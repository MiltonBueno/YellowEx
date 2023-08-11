import 'package:shared_preferences/shared_preferences.dart';

class UserClass {

  String name;
  String email;
  String username;
  String password;
  bool notificationRead;
  List<int> favoritedProducts;
  List<int> postedProducts;
  List<int> toBuyProducts;

  UserClass(this.name, this.email, this.username, this.password, this.notificationRead, this.favoritedProducts, this.postedProducts, this.toBuyProducts);

  // User({this.name = "", this.email = "", this.username = "", this.password = ""});
  //Esse construtor deixa opcional

  String userToString() {

    String favoritedProductsString = favoritedProducts.map((productId) => productId.toString()).join('/');
    String postedProductsString = postedProducts.map((productId) => productId.toString()).join('/');
    String toBuyProductsString = toBuyProducts.map((productId) => productId.toString()).join('/');

    return '$name|$email|$username|$password|$notificationRead|$favoritedProductsString|$postedProductsString|$toBuyProductsString';
  }

}

class User {

  List<UserClass> registeredUsersList = [];

  static String keyRegisteredUsers = "registeredUsers";
  static String userLoggedKey = "userLoggedUsername";
  static UserClass? loggedUser;

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
      UserClass("Teste", "teste@email.com", "teste", "teste", false, [], [], []),
      UserClass("Emily Johnson", "emilyj@email.com", "emilyj82", "p@ssw0rd", false, [], [], []),
      UserClass("Daniel Ramirez", "danielr@email.com", "danielr29", "c00lPass", false, [], [], []),
      UserClass("Sophie Lee", "sophiel123@email.com", "sophiel123", "1qazxsw2", false, [], [], []),
      UserClass("Michael Patel", "michaelpatel@email.com", "mpatel86", "MyPassWord123", false, [], [], []),
      UserClass("Julia Wilson", "juliawilson@email.com", "juliawilson23", "s3cur3P@ss", false, [], [], []),
      UserClass("Liam Davis", "liamdavis@email.com", "liamdavis98", "P@ssw0rd!", false, [], [], [])
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
      List<int> favoritedProductsList = parts[5].isNotEmpty
          ? parts[5].split('/').map((number) => int.parse(number)).toList()
          : [];
      List<int> postedProductsList = parts[6].isNotEmpty
          ? parts[6].split('/').map((number) => int.parse(number)).toList()
          : [];
      List<int> toBuyProductsList = parts[7].isNotEmpty
          ? parts[7].split('/').map((number) => int.parse(number)).toList()
          : [];
      return UserClass(parts[0], parts[1], parts[2], parts[3], parts[4] == "true", favoritedProductsList, postedProductsList, toBuyProductsList);
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