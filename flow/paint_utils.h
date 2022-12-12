// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef FLUTTER_FLOW_PAINT_UTILS_H_
#define FLUTTER_FLOW_PAINT_UTILS_H_

#include "flutter/display_list/display_list_builder.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkColor.h"
#include "third_party/skia/include/core/SkRect.h"

namespace flutter {

typedef void (*CheckerboardFunc)(SkCanvas*, DisplayListBuilder*, const SkRect&);

void DrawCheckerboard(SkCanvas* canvas,
                      DisplayListBuilder* builder,
                      const SkRect& rect);
void DrawCheckerboard(SkCanvas* canvas, const SkRect& rect);
void DrawCheckerboard(DisplayListBuilder* builder, const SkRect& rect);

}  // namespace flutter

#endif  // FLUTTER_FLOW_PAINT_UTILS_H_
