// https://javiercbk.github.io/json_to_dart/
class Person {
  String? name;
  int? age;
  String? city;
  List<Address>? address;

  Person({this.name, this.age, this.city, this.address});

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    city = json['city'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['city'] = this.city;
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? country;
  String? city;

  Address({this.country, this.city});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['Country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Country'] = this.country;
    data['city'] = this.city;
    return data;
  }
}
