import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:op_advisor/backend/model/plan_status_screen_data.dart';

const host = "http://192.168.31.22:8080";

Future<PlanStatusScreenData> fetchCurrentMonthPlan() {
  return http
      .get("$host/plan/current", headers: {"account": "1"}).then((value) {
    return PlanStatusScreenData.fromJson(json.decode(value.body));
  }).catchError((onError) {
    print(onError);
    throw onError;
  });
}

Future<int> updateCurrentMonthPlan(PlanStatusScreenData data) {
  return http
      .put("$host/plan/current",
          headers: {
            "account": "1",
            "Content-Type": "application/json"
          },
          body: json.encode(data.toJson()))
      .then((value) => value.statusCode);
}
