import 'package:flutter/material.dart';
import 'package:result_checker/app/app_routes.dart';

Future pushNamed(String name, [Object? value]) => AppKeys.navigatorKey.currentState!.pushNamed(name, arguments: value);

Future pushNamedReplace(String route) => AppKeys.navigatorKey.currentState!.pushReplacementNamed(route);

Future pushNamedRemoveAll(String route, [bool hasBack = true]) =>
    AppKeys.navigatorKey.currentState!.pushNamedAndRemoveUntil(route, (_) => false, arguments: hasBack);

Future replaceNamedRoute(String route, [bool hasBack = true]) =>
    AppKeys.navigatorKey.currentState!.pushReplacementNamed(route, arguments: hasBack);

void pop() => AppKeys.navigatorKey.currentState!.pop();

void popWithValue(value) => AppKeys.navigatorKey.currentState!.pop(value);

void popAllRoutes() => AppKeys.navigatorKey.currentState!.popUntil((route) => false);

void popUntil(String untilRouteName) =>
    AppKeys.navigatorKey.currentState!.popUntil((route) => route.settings.name == untilRouteName);
