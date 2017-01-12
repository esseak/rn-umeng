//
//  RCTUmeng.h
//  RCTUmeng
//
//  Created by Mike on 16/3/30.
//  Copyright © 2016年 hyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCTUmeng : NSObject <RCTBridgeModule>
- (void) startWithAppkey:(NSString *) appkey;
- (void) setDebugMode:(BOOL)value;
- (void) onEvent:(NSString *)eventId;
@end
