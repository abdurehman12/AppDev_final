class ProductModels {
  String? Name;
  // String? Price;
  // String? Description;
  // String? Image;
  // String? Category;
  // String? id;
  // String? Color;
  String? Email;
  String? phone;

  ProductModels({this.Name, this.Email, this.phone});

  void fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    // Price = json['Price'];
    // Description = json['Description'];
    // Image = json['Image'];
    // Category = json['Category'];
    // id = json['id'];
    // Color = json['Color'];
    Email = json['Email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.Name;
    // data['Price'] = this.Price;
    // data['Description'] = this.Description;
    // data['Image'] = this.Image;
    // data['Category'] = this.Category;
    // data['id'] = this.id;
    // data['Color'] = this.Color;
    data['Email'] = this.Email;
    data['phone'] = this.phone;

    return data;
  }
}
