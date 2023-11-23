class Users{
   String? user_id;
  String? password;
  String? user_name;

  Users({
    this.user_id,
     this.password,
    this.user_name,
});
  factory
      Users.fromMap(Map<dynamic,dynamic>json){
    return Users(
      user_id: json['user_id'],
      password: json['password'],
      user_name: json['user_name']
    );
  }
  Map<String,dynamic>toMap(){
    return{
      'user_id':user_id,
      'userPassword':password,
      'user_name':user_name,
    };
  }
}