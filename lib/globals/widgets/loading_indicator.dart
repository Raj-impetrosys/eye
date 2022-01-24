import 'dart:ui';

import 'package:flutter/material.dart';

loader() => Container(
  color: Colors.black26,
  child:   const Center(
        child: CircularProgressIndicator(),
      ),
);
