class userModel {
  int? id;
  String? name;
  String? userName;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  userModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  userModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['userName'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
    website = json['website'];
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }
}

class Address {
  String? street;
  String? suite;
  String? city;
  String? zipCode;
  Geo? geo;

  Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipCode,
      required this.geo});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipCode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipCode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Company {
  String? name;
  String? catchPhrase;
  String? bs;
  Company({required this.name, required this.catchPhrase, required this.bs});

  Company.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    this.name = data['name'];
    this.catchPhrase = data['catchPhrase'];
    this.bs = data['bs'];
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;
  Geo({required this.lat, required this.lng});

  Geo.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
