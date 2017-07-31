//
//  RCTUmeng.m
//  RCTUmeng
//
//  Created by aevit on 2017/7/26.
//  Copyright © 2017年 aevit. All rights reserved.
//

#import "RCTUmeng.h"

#import <UMMobClick/MobClick.h>
//#import "MobClick.h"


@implementation RCTUmeng

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(setCrashReportEnabled:(BOOL)value)
{
    [MobClick setCrashReportEnabled:value];
}

RCT_EXPORT_METHOD(enableEncrypt:(BOOL)value)
{
    [MobClick setEncryptEnabled:value];
}

RCT_EXPORT_METHOD(startWithAppkey:(NSString *)appkey)
{
    UMConfigInstance.appKey = appkey;
    [MobClick startWithConfigure:UMConfigInstance];
    //    [MobClick startWithAppkey:appkey];
}

RCT_EXPORT_METHOD(setAppVersion:(NSString*)version)
{
    [MobClick setAppVersion:version];
}

RCT_EXPORT_METHOD(setDebugMode:(BOOL)value)
{
    [MobClick setLogEnabled:value];
}

//RCT_EXPORT_METHOD(onProfileSignIn:(NSString *)puid)
//{
//    NSLog(@"onProfileSignIn");
//    [MobClick profileSignInWithPUID:puid];
//}

RCT_EXPORT_METHOD(onProfileSignIn:(NSString *)puid provider:(NSString *)provider)
{
    [MobClick profileSignInWithPUID:puid provider:provider];
}

RCT_EXPORT_METHOD(onProfileSignOff)
{
    [MobClick profileSignOff];
}

RCT_EXPORT_METHOD(onPageStart:(NSString *)pageName)
{
    [MobClick beginLogPageView:pageName];
}

RCT_EXPORT_METHOD(onPageEnd:(NSString *)pageName)
{
    [MobClick endLogPageView:pageName];
}

RCT_EXPORT_METHOD(logPageView:(NSString *)pageName seconds:(int)seconds)
{
    [MobClick logPageView:pageName seconds:seconds];
    
}

RCT_EXPORT_METHOD(onEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(NSString *)counter)
{
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

RCT_EXPORT_METHOD(getDeviceInfo:(RCTResponseSenderBlock)callback)
{
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    NSString *strInfo = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    callback(@[strInfo]);
}

@end
