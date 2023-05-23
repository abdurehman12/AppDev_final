class userModel {
  String? Fname;
  String? Lname;
  String? email;
  String? uid;

  userModel({this.Fname, this.Lname, this.email, this.uid});

  get type => null;

  void fromJson(Map<String, dynamic> json) {
    Fname = json['Fname'];
    Lname = json['Lname'];
    email = json['email'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Fname'] = this.Fname;
    data['Lname'] = this.Lname;
    data['email'] = this.email;
    data['uid'] = this.uid;
    return data;
  }
}
