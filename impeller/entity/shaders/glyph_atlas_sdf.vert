// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <impeller/types.glsl>

#include <impeller/transform.glsl>

uniform FrameInfo {
  mat4 mvp;
}
frame_info;

in vec2 unit_position;
in vec2 destination_position;
in vec2 destination_size;
in vec2 source_position;
in vec2 source_glyph_size;

out vec2 v_unit_position;
out vec2 v_source_position;
out vec2 v_source_glyph_size;

void main() {
  gl_Position = IPPositionForGlyphPosition(
      frame_info.mvp, unit_position, destination_position, destination_size);
  v_unit_position = unit_position;
  v_source_position = source_position;
  v_source_glyph_size = source_glyph_size;
}
