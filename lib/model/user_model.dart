class AppUser {
  int id;
  String firstName;
  String lastName;
  String email;
  String mobileNumber;
  String accountType;
  String gender;

  AppUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.accountType,
    this.gender,
  });
  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['full_name'];
    lastName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile'];
    accountType = json['person_type'];
    gender = 'male';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['accountType'] = this.accountType;
    data['gender'] = this.gender;
    return data;
  }

  static initial() {}
}
