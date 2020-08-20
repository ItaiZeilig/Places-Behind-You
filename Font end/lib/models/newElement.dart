import 'dart:convert';

NewElement newElementFromJson(String str) => NewElement.fromJson(json.decode(str));

String newElementToJson(NewElement data) => json.encode(data.toJson());

class NewElement {
    NewElement({
        this.type,
        this.name,
        this.active,
        this.location,
        this.elementAttributes,
    });

    String type;
    String name;
    bool active;
    NewLocation location;
    NewElementAttributes elementAttributes;

    factory NewElement.fromJson(Map<String, dynamic> json) => NewElement(
        type: json["type"],
        name: json["name"],
        active: json["active"],
        location: NewLocation.fromJson(json["location"]),
        elementAttributes: NewElementAttributes.fromJson(json["elementAttributes"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "active": active,
        "location": location.toJson(),
        "elementAttributes": elementAttributes.toJson(),
    };
}

class NewElementAttributes {
    NewElementAttributes({
        this.description,
        this.rate,
        this.comments,
        this.pictures,
    });

    String description;
    int rate;
    List<dynamic> comments;
    List<dynamic> pictures;

    factory NewElementAttributes.fromJson(Map<String, dynamic> json) => NewElementAttributes(
        description: json["description"],
        rate: json["rate"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        pictures: List<dynamic>.from(json["pictures"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "rate": rate,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
    };
}

class NewLocation {
    NewLocation({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory NewLocation.fromJson(Map<String, dynamic> json) => NewLocation(
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}
