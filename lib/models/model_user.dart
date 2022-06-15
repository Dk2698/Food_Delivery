// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  String? name;
  String? age;
  String? city;
  List<Address>? address;
  Person({
    this.name,
    this.age,
    this.city,
    this.address,
  });
  // give to map
  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    city = json['city'];
    // this list take model
    if (json['address'] != null) {
      address = <Address>[]; // empty
      for (var element in (json['address'] as List)) {
        // Address.fromJson(element);
        address!.add(Address.fromJson(element));
      }
    }
  }
  // Person person
  // person.age
}

class Address {
  String? country;
  String? city;
  Address({
    this.country,
    this.city,
  });

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
  }
}

// nested map
void main() {
  var myMap = {
    "name": "kumar",
    "age": 24,
    "city": "Banglore",
    "address": [
      {"Country": "china", "city": "bejing"},
      {"Country": "bangldesh", "city": "Dhaka"}
    ]
  };

  var obj = Person.fromJson(myMap); // passing map
  print(obj);
  print(obj.age);
  print(obj.address);

  // access the list from nested model
  var myAddress = obj.address;
  myAddress!.map((e) {
    print(e.country);
  }).toList();
}
