// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Cocoa/Cocoa.h>
#import <OCMock/OCMock.h>

#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterSurfaceManager.h"
#include "flutter/testing/testing.h"
#include "gtest/gtest.h"

@interface TestView : NSView

- (nonnull instancetype)init;

@end

@implementation TestView

- (instancetype)init {
  self = [super initWithFrame:NSZeroRect];
  if (self) {
    [self setWantsLayer:YES];
  }
  return self;
}

@end

namespace flutter::testing {

static FlutterSurfaceManager* CreateSurfaceManager() {
  id<MTLDevice> device = MTLCreateSystemDefaultDevice();
  id<MTLCommandQueue> commandQueue = [device newCommandQueue];
  TestView* metalView = [[TestView alloc] init];
  CALayer* layer = reinterpret_cast<CALayer*>(metalView.layer);
  return [[FlutterSurfaceManager alloc] initWithDevice:device
                                          commandQueue:commandQueue
                                                 layer:layer];
}

TEST(FlutterSurfaceManager, EnsureSizeUpdatesSize) {
  FlutterSurfaceManager* surfaceManager = CreateSurfaceManager();
  CGSize size = CGSizeMake(100, 50);
  [surfaceManager ensureSurfaceSize:size];
  id<MTLTexture> texture = [surfaceManager renderBuffer].texture;
  CGSize textureSize = CGSizeMake(texture.width, texture.height);
  ASSERT_TRUE(CGSizeEqualToSize(size, textureSize));
}

TEST(FlutterSurfaceManager, EnsureSizeUpdatesSizeForBackBuffer) {
  FlutterSurfaceManager* surfaceManager = CreateSurfaceManager();
  CGSize size = CGSizeMake(100, 50);
  [surfaceManager ensureSurfaceSize:size];
  [surfaceManager renderBuffer];  // make sure we have back buffer
  [surfaceManager swapBuffers];
  id<MTLTexture> texture = [surfaceManager renderBuffer].texture;
  CGSize textureSize = CGSizeMake(texture.width, texture.height);
  ASSERT_TRUE(CGSizeEqualToSize(size, textureSize));
}

}  // namespace flutter::testing
