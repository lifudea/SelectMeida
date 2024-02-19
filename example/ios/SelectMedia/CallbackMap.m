//
//  CallbackMap.m
//  Runner
//
//  Created by hello on 2024/2/7.
//

#import "CallbackMap.h"

static int CODE_SUCCESS = 200;

@implementation CallbackMap



+ (NSDictionary *)success {
    NSNumber *number = [[NSNumber alloc] initWithInt:CODE_SUCCESS];
    NSDictionary *map = @{@"code": number};
    return map;
}

@end
