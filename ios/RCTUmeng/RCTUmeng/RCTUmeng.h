//
//  RCTUmeng.h
//  RCTUmeng
//
//  Created by Mike on 16/3/30.
//  Copyright © 2016年 hyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#else
#import "RCTBridgeModule.h"
#endif

@interface RCTUmeng : NSObject <RCTBridgeModule>
- (void) startWithAppkey:(NSString *) appkey;
- (void) setDebugMode:(BOOL)value;
- (void) onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(NSString *)counter;
@end
