import 'package:flutter/material.dart';

import '../model/dependencies.dart';

class DependenciesScope extends InheritedWidget {
  const DependenciesScope({
    required super.child,
    required this.dependencies,
    super.key,
  });

  final Dependencies dependencies;

  static DependenciesScope? maybeOf(BuildContext context,
          {bool listen = false}) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<DependenciesScope>()
          : (context
              .getElementForInheritedWidgetOfExactType<DependenciesScope>()
              ?.widget as DependenciesScope);

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a DependenciesScope of the exact type',
        'out_of_scope',
      );

  static Dependencies of(BuildContext context, {bool listen = false}) =>
      maybeOf(context, listen: listen)?.dependencies ??
      _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
