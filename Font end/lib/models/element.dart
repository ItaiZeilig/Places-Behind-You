import 'dart:convert';

import 'package:placebehindyou/models/user.dart';
List<SingleElement> elementsFromJson(String str) => List<SingleElement>.from(json.decode(str).map((x) => SingleElement.fromJson(x)));

SingleElement singleElementFromJson(String str) => SingleElement.fromJson(json.decode(str));

String singleElementToJson(SingleElement data) => json.encode(data.toJson());

class SingleElement {
    SingleElement({
        this.elementId,
        this.type,
        this.name,
        this.active,
        this.createTimestamp,
        this.createdBy,
        this.location,
        this.elementAttributes,
    });

    ElementId elementId;
    String type;
    String name;
    bool active;
    String createTimestamp;
    CreatedBy createdBy;
    Location location;
    ElementAttributes elementAttributes;

    factory SingleElement.fromJson(Map<String, dynamic> json) => SingleElement(
        elementId: ElementId.fromJson(json["elementId"]),
        type: json["type"],
        name: json["name"],
        active: json["active"],
        createTimestamp: json["createTimestamp"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        location: Location.fromJson(json["location"]),
        elementAttributes: ElementAttributes.fromJson(json["elementAttributes"]),
    );

    Map<String, dynamic> toJson() => {
        "elementId": elementId.toJson(),
        "type": type,
        "name": name,
        "active": active,
        "createTimestamp": createTimestamp,
        "createdBy": createdBy.toJson(),
        "location": location.toJson(),
        "elementAttributes": elementAttributes.toJson(),
    };
}

class CreatedBy {
    CreatedBy({
        this.userId,
    });

    UserId userId;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        userId: UserId.fromJson(json["userId"]),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId.toJson(),
    };
}


class ElementAttributes {
    ElementAttributes({
        this.comments,
        this.rate,
        this.numRaters,
        this.description,
        this.pictures,
    });

    List<Comment> comments;
    int rate;
    int numRaters;
    String description;
    List<String> pictures;

    factory ElementAttributes.fromJson(Map<String, dynamic> json) => ElementAttributes(
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        rate: json["rate"],
        numRaters: json["numRaters"],
        description: json["description"],
        pictures: List<String>.from(json["pictures"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "rate": rate,
        "numRaters": numRaters,
        "description": description,
        "pictures": List<dynamic>.from(pictures.map((x) => x)),
    };
}

class Comment {
    Comment({
        this.userName,
        this.comment,
        this.id,
    });

    String userName;
    String comment;
    String id;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userName: json["userName"],
        comment: json["comment"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "comment": comment,
        "id": id,
    };
}

class ElementId {
    ElementId({
        this.domain,
        this.id,
    });

    String domain;
    String id;

    factory ElementId.fromJson(Map<String, dynamic> json) => ElementId(
        domain: json["domain"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "id": id,
    };
}

class Location {
    Location({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
    };
}