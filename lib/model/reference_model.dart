// To parse this JSON data, do
//
//     final reference = referenceFromJson(jsonString);

import 'dart:convert';

Reference referenceFromJson(String str) => Reference.fromJson(json.decode(str));

String referenceToJson(Reference data) => json.encode(data.toJson());

class Reference {
  Reference({
    this.reference,
  });

  ReferenceClass reference;

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        reference: ReferenceClass.fromJson(json["reference"]),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference.toJson(),
      };
}

class ReferenceClass {
  ReferenceClass({
    this.id,
    this.charity,
    this.support,
    this.aboutService,
  });

  int id;
  AboutService charity;
  AboutService support;
  AboutService aboutService;

  factory ReferenceClass.fromJson(Map<String, dynamic> json) => ReferenceClass(
        id: json["id"],
        charity: AboutService.fromJson(json["charity"]),
        support: AboutService.fromJson(json["support"]),
        aboutService: AboutService.fromJson(json["about_service"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "charity": charity.toJson(),
        "support": support.toJson(),
        "about_service": aboutService.toJson(),
      };
}

class AboutService {
  AboutService({
    this.description,
    this.imagePath,
    this.id,
    this.name,
    this.charities,
  });

  String description;
  String imagePath;
  int id;
  String name;
  List<Charity> charities;

  factory AboutService.fromJson(Map<String, dynamic> json) => AboutService(
        description: json["description"] == null ? null : json["description"],
        imagePath: "https://backend-pin-home-server.site" + json["image_path"],
        id: json["id"],
        name: json["name"],
        charities: json["charities"] == null
            ? null
            : List<Charity>.from(
                json["charities"].map((x) => Charity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "image_path": imagePath,
        "id": id,
        "name": name,
        "charities": charities == null
            ? null
            : List<dynamic>.from(charities.map((x) => x.toJson())),
      };
}

class Charity {
  Charity({
    this.description,
    this.charitiesAddress,
    this.charitiesContacts,
    this.isActive,
    this.id,
    this.imagesCharities,
    this.charities,
    this.charitiesSocialNetworks,
    this.idCharity,
    this.name,
  });

  String description;
  List<CharitiesAddress> charitiesAddress;
  List<CharitiesContact> charitiesContacts;
  bool isActive;
  int id;
  List<ImagesCharity> imagesCharities;
  int charities;
  List<CharitiesSocialNetwork> charitiesSocialNetworks;
  int idCharity;
  String name;

  factory Charity.fromJson(Map<String, dynamic> json) => Charity(
        description: json["description"],
        charitiesAddress: List<CharitiesAddress>.from(
            json["charities_address"].map((x) => CharitiesAddress.fromJson(x))),
        charitiesContacts: List<CharitiesContact>.from(
            json["charities_contacts"]
                .map((x) => CharitiesContact.fromJson(x))),
        isActive: json["is_active"],
        id: json["id"],
        imagesCharities: List<ImagesCharity>.from(
            json["images_charities"].map((x) => ImagesCharity.fromJson(x))),
        charities: json["charities"],
        charitiesSocialNetworks: List<CharitiesSocialNetwork>.from(
            json["charities_social_networks"]
                .map((x) => CharitiesSocialNetwork.fromJson(x))),
        idCharity: json["id_charity"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "charities_address":
            List<dynamic>.from(charitiesAddress.map((x) => x.toJson())),
        "charities_contacts":
            List<dynamic>.from(charitiesContacts.map((x) => x.toJson())),
        "is_active": isActive,
        "id": id,
        "images_charities":
            List<dynamic>.from(imagesCharities.map((x) => x.toJson())),
        "charities": charities,
        "charities_social_networks":
            List<dynamic>.from(charitiesSocialNetworks.map((x) => x.toJson())),
        "id_charity": idCharity,
        "name": name,
      };
}

class CharitiesAddress {
  CharitiesAddress({
    this.charitiesAddress,
    this.address,
    this.id,
    this.idCharities,
  });

  int charitiesAddress;
  String address;
  int id;
  int idCharities;

  factory CharitiesAddress.fromJson(Map<String, dynamic> json) =>
      CharitiesAddress(
        charitiesAddress: json["charities_address"],
        address: json["address"],
        id: json["id"],
        idCharities: json["id_charities"],
      );

  Map<String, dynamic> toJson() => {
        "charities_address": charitiesAddress,
        "address": address,
        "id": id,
        "id_charities": idCharities,
      };
}

class CharitiesContact {
  CharitiesContact({
    this.charitiesContacts,
    this.contact,
    this.id,
    this.idCharities,
  });

  int charitiesContacts;
  String contact;
  int id;
  int idCharities;

  factory CharitiesContact.fromJson(Map<String, dynamic> json) =>
      CharitiesContact(
        charitiesContacts: json["charities_contacts"],
        contact: json["contact"],
        id: json["id"],
        idCharities: json["id_charities"],
      );

  Map<String, dynamic> toJson() => {
        "charities_contacts": charitiesContacts,
        "contact": contact,
        "id": id,
        "id_charities": idCharities,
      };
}

class CharitiesSocialNetwork {
  CharitiesSocialNetwork({
    this.socialNetworks,
    this.charitiesSocialNetworks,
    this.id,
    this.idCharities,
  });

  String socialNetworks;
  int charitiesSocialNetworks;
  int id;
  int idCharities;

  factory CharitiesSocialNetwork.fromJson(Map<String, dynamic> json) =>
      CharitiesSocialNetwork(
        socialNetworks: json["social_networks"],
        charitiesSocialNetworks: json["charities_social_networks"],
        id: json["id"],
        idCharities: json["id_charities"],
      );

  Map<String, dynamic> toJson() => {
        "social_networks": socialNetworks,
        "charities_social_networks": charitiesSocialNetworks,
        "id": id,
        "id_charities": idCharities,
      };
}

class ImagesCharity {
  ImagesCharity({
    this.idCharities,
    this.imagePath,
    this.id,
    this.imagesCharities,
    this.created,
  });

  int idCharities;
  String imagePath;
  int id;
  int imagesCharities;
  DateTime created;

  factory ImagesCharity.fromJson(Map<String, dynamic> json) => ImagesCharity(
        idCharities: json["id_charities"],
        imagePath: "https://backend-pin-home-server.site" + json["image_path"],
        id: json["id"],
        imagesCharities: json["images_charities"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id_charities": idCharities,
        "image_path": imagePath,
        "id": id,
        "images_charities": imagesCharities,
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
      };
}
