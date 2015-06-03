// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:sky' as sky;
import '../fn2.dart';
import '../rendering/box.dart';

// TODO(eseidel): This should use package:.
const String kAssetBase = '/packages/sky/assets/material-design-icons';

class Icon extends Component {
  int size;
  String type;

  Icon({
    String key,
    this.size,
    this.type: ''
  }) : super(key: key);

  UINode build() {
    String category = '';
    String subtype = '';
    List<String> parts = type.split('/');
    if (parts.length == 2) {
      category = parts[0];
      subtype = parts[1];
    }
    // TODO(jackson): Use a real image.
    return new Container(
      desiredSize: new sky.Size(size.toDouble(), size.toDouble()),
      decoration: new BoxDecoration(backgroundColor: const sky.Color(0xFFFF0000))
    );
    // return new Image(width: size, height: size,
    //   src: '${kAssetBase}/${category}/2x_web/ic_${subtype}_${size}dp.png');
  }
}
