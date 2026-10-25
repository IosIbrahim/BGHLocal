
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';


class ObjectDeSerializer<T> implements JsonConverter<T, Map<String, dynamic>> {
  @override
  T fromJson(Map<String, dynamic> json) {
    try {
      final data = json.values.first;

      if (data is Map<String, dynamic>) {
        return data as T; // Cast the map to the expected type
      } else if (data is List && data.isNotEmpty) {
        // Return the first item in the list if it's not empty
        return data[0] as T;
      } else {
        throw Exception('Invalid data format');
      }
    } catch (e) {
      throw Exception('Error deserializing data: $e');
    }
  }

  @override
  Map<String, dynamic> toJson(T object) {
    // Implement the serialization logic here if necessary
    return {}; // Return an empty map or actual serialization logic
  }
}

class ArrayDeSerializer<T> implements JsonConverter<List<T>, List<dynamic>> {
  const ArrayDeSerializer();

  @override
  List<T> fromJson(List<dynamic> json) {
    try {
      return json.map((item) => item as T).toList();
    } catch (e) {
      assert(() { debugPrint("Error in array deserialization: $e"); return true; }());
    }
    return [];
  }

  @override
  List<dynamic> toJson(List<T> list) {
    return list.map((item) => item).toList();
  }
}
