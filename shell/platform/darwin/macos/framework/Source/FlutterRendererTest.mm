// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <OCMock/OCMock.h>

#import "flutter/shell/platform/darwin/macos/framework/Headers/FlutterEngine.h"
#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterDartProject_Internal.h"
#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterEngine_Internal.h"
#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterRenderer.h"
#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterView.h"
#import "flutter/shell/platform/darwin/macos/framework/Source/FlutterViewController_Internal.h"
#include "flutter/shell/platform/embedder/embedder.h"
#include "flutter/shell/platform/embedder/test_utils/proc_table_replacement.h"
#include "flutter/testing/testing.h"

namespace flutter::testing {

namespace {
// Returns an engine configured for the test fixture resource configuration.
FlutterEngine* CreateTestEngine() {
  NSString* fixtures = @(testing::GetFixturesPath());
  FlutterDartProject* project = [[FlutterDartProject alloc]
      initWithAssetsPath:fixtures
             ICUDataPath:[fixtures stringByAppendingString:@"/icudtl.dat"]];
  return [[FlutterEngine alloc] initWithName:@"test" project:project allowHeadlessExecution:true];
}

void SetEngineDefaultView(FlutterEngine* engine, id flutterView) {
  id mockFlutterViewController = OCMClassMock([FlutterViewController class]);
  OCMStub([mockFlutterViewController flutterView]).andReturn(flutterView);
  [engine setViewController:mockFlutterViewController];
}

}  // namespace

TEST(FlutterRenderer, PresentDelegatesToFlutterView) {
  FlutterEngine* engine = CreateTestEngine();
  FlutterRenderer* renderer = [[FlutterRenderer alloc] initWithFlutterEngine:engine];
  id mockFlutterView = OCMClassMock([FlutterView class]);
  SetEngineDefaultView(engine, mockFlutterView);
  [(FlutterView*)[mockFlutterView expect] present];
  [renderer present:kFlutterDefaultViewId];
}

TEST(FlutterRenderer, TextureReturnedByFlutterView) {
  FlutterEngine* engine = CreateTestEngine();
  FlutterRenderer* renderer = [[FlutterRenderer alloc] initWithFlutterEngine:engine];
  id mockFlutterView = OCMClassMock([FlutterView class]);
  SetEngineDefaultView(engine, mockFlutterView);
  FlutterFrameInfo frameInfo;
  frameInfo.struct_size = sizeof(FlutterFrameInfo);
  FlutterUIntSize dimensions;
  dimensions.width = 100;
  dimensions.height = 200;
  frameInfo.size = dimensions;
  CGSize size = CGSizeMake(dimensions.width, dimensions.height);
  [[mockFlutterView expect] backingStoreForSize:size];
  [renderer createTextureForView:kFlutterDefaultViewId size:size];
}

}  // namespace flutter::testing
