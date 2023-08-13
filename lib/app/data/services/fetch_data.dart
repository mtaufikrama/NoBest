import 'package:dio/dio.dart';
import 'package:nobes/app/data/model/usda_fdcid.dart';
import 'package:nobes/app/data/services/query_parameter.dart';

import '../model/usda_search.dart';

class API {
  static const baseUrl = "https://api.nal.usda.gov/fdc/v1";
  static const apiKey = '0ZedjayQDQmx0GNpYsT1jfpPdzbYdaZEO4y3wyb1';
  static Future<USDASearch> getSearch(
      {required String query,
      int? pageNumber,
      List<String>? dataType,
      String? brandOwner,
      String? sortOrder,
      String? sortBy,
      int? pageSize}) async {
    final response = await Dio().get("$baseUrl/foods/search",
        options: Options(
          contentType: 'application/json',
        ),
        queryParameters: {
          'api_key': apiKey,
          'query': query,
          'dataType': dataType ?? [DataTypes.branded, DataTypes.surveyFNDDS],
          'brandOwner': brandOwner ?? '',
          'pageNumber': pageNumber ?? '',
          'sortOrder': sortOrder ?? '',
          'sortBy': sortBy ?? '',
          'pageSize': pageSize ?? '100',
        });
    USDASearch obj;
    if (response.statusCode == 200) {
      obj = USDASearch.fromJson(response.data);
    } else {
      obj = USDASearch();
    }
    return obj;
  }

  static Future<USDAFdcId> getFdcId({required int fdcid}) async {
    final response = await Dio().get("$baseUrl/food/$fdcid",
        options: Options(
          contentType: 'application/json',
        ),
        queryParameters: {
          'api_key': apiKey,
        });
    USDAFdcId obj;
    if (response.statusCode == 200) {
      obj = USDAFdcId.fromJson(response.data);
    } else {
      obj = USDAFdcId();
    }
    return obj;
  }
}
