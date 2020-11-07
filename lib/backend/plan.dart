import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';

import 'model/suggestion.dart';
import 'model/transaction.dart';

const host = "192.168.31.22:8080";

Future<PlanStatusScreenData> fetchCurrentMonthPlan() {
  return http
      .get("http://$host/plan/current", headers: {"account": "1"}).then((value) {
    return PlanStatusScreenData.fromJson(json.decode(value.body));
  }).catchError((onError) {
    print(onError);
    throw onError;
  });
}

Future<int> updateCurrentMonthPlan(PlanStatusScreenData data, int month, int year) {
  Map<String, String> queryParameters = params(month, year);
  final uri = Uri.http(host, '/plan', queryParameters);
  return http
      .put(uri,
          headers: {
            "account": "1",
            "Content-Type": "application/json"
          },
          body: json.encode(data.toJson()))
      .then((value) => value.statusCode);
}

Future<PlanStatusScreenData> fetchPlanForEdit(int month, int year) {
  Map<String, String> queryParameters = params(month, year);
  final uri = Uri.http(host, '/plan', queryParameters);
  return http.get(uri, headers: {"account": "1"}).then((value) {
    return PlanStatusScreenData.fromJson(json.decode(value.body));
  }).then((value) {
    if(value.categories.isEmpty) {
      return http.post(uri, headers: {"account": "1"});
    } else {
      return value;
    }
  }).then((value) {
    if(value is PlanStatusScreenData) {
      return value;
    }
    return http.get(uri, headers: {"account": "1"});
  }).then((value) {
    if(value is PlanStatusScreenData) {
      return value;
    }
    if(value is http.Response) {
      return PlanStatusScreenData.fromJson(json.decode(value.body));
    }
    throw Exception("Failed to fetch");
  }).catchError((onError) {
    print(onError);
    throw onError;
  });
}

Map<String, String> params(int month, int year) {
  final queryParameters = {
    'month': month.toString(),
    'year': year.toString(),
  };
  return queryParameters;
}

Future<List<Suggestion>> fetchSuggestions() {
  final uri = Uri.http(host, '/plan/suggestions');
  return http.get(uri, headers: {"account": "1"}).then((value) {
    Iterable list = json.decode(value.body);
    return list.map((model)=> Suggestion.fromJson(model)).toList();
  }).catchError((onError) {
    print(onError);
    throw onError;
  });
}

Future<List<Transaction>> fetchTransactions(int categoryId, int month, int year) {
  final queryParameters = {
    'category': categoryId.toString(),
    'month': month.toString(),
    'year': year.toString(),
  };
  final uri = Uri.http(host, '/plan/category', queryParameters);
  return http.get(uri, headers: {"account": "1"}).then((value) {
    Iterable list = json.decode(value.body);
    return list.map((model)=> Transaction.fromJson(model)).toList();
  }).catchError((onError) {
    print(onError);
    throw onError;
  });
}