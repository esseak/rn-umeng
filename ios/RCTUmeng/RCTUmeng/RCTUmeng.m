//
//  RCTUmeng.m
//  RCTUmeng
//
//  Created by Mike on 16/3/30.
//  Copyright © 2016年 hyz. All rights reserved.
//

#import "RCTUmeng.h"
#import "MobClick.h"


@implementation RCTUmeng

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(setCrashReportEnabled:(BOOL)value)
{
    NSLog(@"setCrashReportEnabled");
    [MobClick setCrashReportEnabled:value];
}

RCT_EXPORT_METHOD(enableEncrypt:(BOOL)value)
{
    NSLog(@"setEncryptEnabled");
    [MobClick setEncryptEnabled:value];
}

RCT_EXPORT_METHOD(startWithAppkey:(NSString *)appkey)
{
    NSLog(@"startWithAppkey");
    [MobClick startWithAppkey:appkey];
}

RCT_EXPORT_METHOD(setDebugMode:(BOOL)value)
{
    NSLog(@"setDebugMode");
    [MobClick setLogEnabled:value];
}

//RCT_EXPORT_METHOD(onProfileSignIn:(NSString *)puid)
//{
//    NSLog(@"onProfileSignIn");
//    [MobClick profileSignInWithPUID:puid];
//}

RCT_EXPORT_METHOD(onProfileSignIn:(NSString *)puid provider:(NSString *)provider)
{
    NSLog(@"onProfileSignIn");
    [MobClick profileSignInWithPUID:puid provider:provider];
}

RCT_EXPORT_METHOD(onProfileSignOff)
{
    NSLog(@"onProfileSignIn");
    [MobClick profileSignOff];
}

RCT_EXPORT_METHOD(onPageStart:(NSString *)pageName)
{
    NSLog(@"onPageStart");
    [MobClick beginLogPageView:pageName];
}

RCT_EXPORT_METHOD(onPageEnd:(NSString *)pageName)
{
    NSLog(@"onPageEnd");
    [MobClick endLogPageView:pageName];
}

RCT_EXPORT_METHOD(logPageView:(NSString *)pageName seconds:(int)seconds)
{
    NSLog(@"logPageView");
    [MobClick logPageView:pageName seconds:seconds];

}

RCT_EXPORT_METHOD(onEvent:(NSString *)eventId)
{
    NSLog(@"onEvent:(NSString *)eventId");
    [MobClick event:eventId];
}

RCT_EXPORT_METHOD(onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(NSString *)counter)
{
    NSLog(@"onEvent:%@ attributes:%@ counter:%@",eventId,attributes,counter);
    if (attributes) {
        if (counter) {
            int intCounter = counter.intValue;
            [MobClick event:eventId attributes:attributes counter:intCounter];
        }else{
            [MobClick event:eventId attributes:attributes];
        }
    }else{
        [MobClick event:eventId];
    }
}

RCT_EXPORT_METHOD(getDeviceInfo)
{
    NSLog(@"getDeviceInfo");
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}


@end
