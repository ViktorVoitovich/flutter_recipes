import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app/core/models/index.dart';

class RecipesService {
  Future<List<Recipe>> getRecipies({
    int offset = 0,
    String category = '',
  }) async {
    final response = await http.get(
      Uri.https(
        'api.spoonacular.com',
        'recipes/complexSearch',
        {
          'number': '5',
          'apiKey': '4d817cbd90a944498a0e114b6a0f5d13',
          'addRecipeInformation': 'true',
          'offset': offset.toString(),
          'query': category,
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> recipes = jsonDecode(response.body)['results'];
      return recipes.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load recipies');
    }
  }

  Future<List<Recipe>> getRecipiesByIds({@required List<String> ids}) async {
    final response = await http.get(
      Uri.https(
        'api.spoonacular.com',
        'recipes/informationBulk',
        {
          'ids': ids.join(','),
          'apiKey': '4d817cbd90a944498a0e114b6a0f5d13',
        },
      ),
    );

    if (response.statusCode == 200) {
      final List<dynamic> recipes = jsonDecode(response.body);
      return recipes.map((recipe) => Recipe.fromJson(recipe)).toList();
    } else {
      throw Exception('Failed to load recipies');
    }
  }
}
