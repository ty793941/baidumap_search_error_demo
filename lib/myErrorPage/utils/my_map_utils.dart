import 'dart:async';
import 'dart:io';

import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart' show BMFCoordinate, BMFMapSDK, BMF_COORD_TYPE;
import 'package:mutex/mutex.dart';

class MyMapUtils {
  static Mutex mapMutex = Mutex();
  static Future<List<BMFSuggestionInfo>?> searchSuggestions({required String keyword, required String cityname, Function(BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode)? callback}) async {
    if (keyword.isEmpty) return null;

    return mapMutex.protect(() async {
      /// 构造检索参数
      BMFSuggestionSearchOption suggestionSearchOption = BMFSuggestionSearchOption(keyword: keyword, cityname: cityname);

      /// 检索实例
      BMFSuggestionSearch suggestionSearch = BMFSuggestionSearch();

      // 使用 Completer 来创建一个可以在稍后完成的 Future
      final completer = Completer<List<BMFSuggestionInfo>?>();

      /// 检索回调
      suggestionSearch.onGetSuggestSearchResult(callback: (BMFSuggestionSearchResult result, BMFSearchErrorCode errorCode) {
        if (callback != null) {
          callback(result, errorCode);
        }
        completer.complete(result.suggestionList); // 在回调中完成 Future
      });

      /// 发起检索
      bool flag = await suggestionSearch.suggestionSearch(suggestionSearchOption);
      if (flag == false) {
        print("地址检索失败，请稍后再试...");
        completer.complete(null); // 检索失败时完成 Future
      }

      return completer.future; // 返回 Future
    });
  }
}

class MyMapPlace {
  final String key;
  final MyLocation location;
  final String uid;
  final String city;
  final String district;
  final String tag;
  final String? address;
  final List<MyPlaceChild>? children;

  MyMapPlace({
    required this.key,
    required this.location,
    required this.uid,
    required this.city,
    required this.district,
    required this.tag,
    this.address,
    this.children,
  });

  factory MyMapPlace.fromJson(Map<String, dynamic> json) {
    return MyMapPlace(
      key: json['key'],
      location: MyLocation.fromJson(json['location']),
      uid: json['uid'],
      city: json['city'],
      district: json['district'],
      tag: json['tag'],
      address: json['address'],
      children: json['children'] != null ? (json['children'] as List).map((e) => MyPlaceChild.fromJson(e)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'location': location.toJson(),
      'uid': uid,
      'city': city,
      'district': district,
      'tag': tag,
      'address': address,
      'children': children?.map((e) => e.toJson()).toList(),
    };
  }
}

class MyLocation {
  final double latitude;
  final double longitude;

  MyLocation({required this.latitude, required this.longitude});

  factory MyLocation.fromJson(Map<String, dynamic> json) {
    return MyLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class MyPlaceChild {
  final String uid;
  final String name;
  final String showName;

  MyPlaceChild({required this.uid, required this.name, required this.showName});

  factory MyPlaceChild.fromJson(Map<String, dynamic> json) {
    return MyPlaceChild(
      uid: json['uid'],
      name: json['name'],
      showName: json['showName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'showName': showName,
    };
  }
}
