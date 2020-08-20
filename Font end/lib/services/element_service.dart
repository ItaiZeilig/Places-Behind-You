import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:placebehindyou/models/element.dart';
import 'package:placebehindyou/models/newElement.dart';

class ElementService extends ChangeNotifier {
  final String userURL = 'http://10.100.102.5:8083/acs/elements';
  final String domain = '2020b.or.zaidman.placebehindyou';

  SingleElement _element;
  SingleElement get getElement => _element;

  List<SingleElement> _allElements;
  List<SingleElement> get getAllElements => _allElements;

  Future<void> createNewElement(String email, NewElement newElement) async {
    final http.Response response = await http.post(
        userURL + '/${domain}/${email}',
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: newElementToJson(newElement));

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      _element = singleElementFromJson(response.body);
      print(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Element');
    }
  }

  Future<void> searchElementByID(String email, String elementID) async {
    final http.Response response = await http
        .get(userURL + '/${domain}/${email}/${domain}/${elementID}', headers: {
      "accept": "application/json",
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      _element = singleElementFromJson(response.body);
      print(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Element');
    }
  }

    Future<void> fetchAllElements(String email) async {
    final http.Response response = await http
        .get(userURL + '/${domain}/${email}', headers: {
      "accept": "application/json",
    });
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      _allElements = elementsFromJson(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Element');
    }
  }

  Future<void> updateElement(String email, SingleElement element) async {
    final http.Response response = await http.put(
        userURL + '/${domain}/${email}/${domain}/${element.elementId.id}',
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: singleElementToJson(element));
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      _element = singleElementFromJson(response.body);
      print(response.body);
      notifyListeners();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load Element');
    }
  }
}
