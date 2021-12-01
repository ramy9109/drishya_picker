import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

///
// ignore: one_member_abstracts
abstract class EditorBackground {
  /// Playgroung builder
  Widget build(BuildContext context);
}

///
class PhotoBackground implements EditorBackground {
  ///
  PhotoBackground({
    this.bytes,
    this.url,
  });

  ///
  final Uint8List? bytes;

  ///
  final String? url;

  ///
  bool get hasData => (url?.isNotEmpty ?? false) || (bytes != null);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Builder(
        builder: (_) {
          if (bytes != null) {
            return Image.memory(bytes!, fit: BoxFit.contain);
          } else if (url != null) {
            return Image.network(url!, fit: BoxFit.cover);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

///
class GradientBackground implements EditorBackground {
  ///
  const GradientBackground({
    this.colors,
    this.gradient,
  }) : assert(
          colors != null || gradient != null,
          "Both colors and gradient canno't be null",
        );

  ///
  final List<Color>? colors;

  ///
  final Gradient? gradient;

  /// First color from the gradient
  Color get firstColor => colors?.first ?? gradient!.colors.first;

  /// Last color from the gradient
  Color get lastColor => colors?.last ?? gradient!.colors.last;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors!,
            ),
      ),
    );
  }
}
