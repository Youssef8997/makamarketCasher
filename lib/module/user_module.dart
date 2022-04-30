class UserModule {
   String? name;
   String? email;
   String? password;
   String? phone;
   String? shopName;
   String? uid;

  UserModule(
      {this.name,
      this.email,
      this.password,
      this.phone,
      this.shopName,
      this.uid});
  UserModule.fromJson(Map<String, dynamic> json)
  {
       name = json['name'];
        email = json['email'];
        password = json['password'];
        phone = json['phone'];
        shopName = json['shopName'];
        uid = json['uid'];
  }
Map<String, dynamic> toJson()
 {
   return {
     'name': name,
     'email': email,
     'password': password,
     'phone': phone,
     'shopName': shopName,
     'uid': uid,
   };
}
}
