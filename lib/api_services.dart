import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:single_data_api/single_post_model.dart';

class ApiServices {
  // With Model

  Future<SinglePostWithModel?> getSinglePostWithModel() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        // add data from url into Model
        SinglePostWithModel model = SinglePostWithModel.fromJson(
          json.decode(response.body),
        );
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Without Model
  Future<dynamic> getSinglePostWithoutModel() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body);
        return data;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
