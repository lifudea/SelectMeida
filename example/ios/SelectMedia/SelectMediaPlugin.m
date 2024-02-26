//
//  SelectMediaPlugin.m
//  Runner
//
//  Created by hello on 2024/2/7.
//

#import <Foundation/Foundation.h>
#import "SelectMediaPlugin.h"
#import "CallbackMap.h"
#import "SelectMedia.h"

@implementation SelectMediaPlugin

FlutterMethodChannel *methodChannel;

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    methodChannel = [FlutterMethodChannel
      methodChannelWithName:@"select_media"
            binaryMessenger:[registrar messenger]];
  SelectMediaPlugin* instance = [[SelectMediaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:methodChannel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"测试的1 " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if(([@"selectMedia" isEqualToString:call.method])){
      NSLog(@"触发了 %@", call.arguments);
      NSDictionary *dictionary = call.arguments;
      NSNumber *maxLength = [dictionary objectForKey:@"maxLength"];
      NSNumber *maxSecond = [dictionary objectForKey:@"maxSecond"];
      NSNumber *mediaType = [dictionary objectForKey:@"mediaType"];
      
      
      NSLog(@"文件类型 %@", maxLength);
      NSLog(@"最大选择数量 %@", maxLength);
      NSLog(@"最大视频时长 %@", maxLength);
      [[SelectMedia alloc] selectMedia:methodChannel withMediaType:mediaType withLength:maxLength withSecond:maxSecond];
      result([CallbackMap success]);
  } else {
      result(FlutterMethodNotImplemented);
  }
}

@end

