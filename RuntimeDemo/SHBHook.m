//
//  SHBHook.m
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import "SHBHook.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "SHBCommonFunctions.h"



@implementation SHBHook

+ (instancetype)sharedInstance {
    static SHBHook *hook = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hook = [[SHBHook alloc] init];
    });
    return hook;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
        Class class1 = [[UIApplication sharedApplication].delegate class];
        Class class2 = [self class];
        
        SEL token = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
        SEL shbToken = @selector(shb_application:didRegisterForRemoteNotificationsWithDeviceToken:);
        
        AssociateWithSelector(class1, token, class2, shbToken);
    }
    return self;
}

- (void)registEnterForeground {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class1 = [[UIApplication sharedApplication].delegate class];
        Class class2 = [self class];
        
        SEL selector1 = @selector(applicationWillEnterForeground:);
        SEL selector2 = @selector(shb_applicationWillEnterForeground:);
        
        AssociateWithSelector(class1, selector1, class2, selector2);
    });
}

- (void)shb_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[SHBHook sharedInstance] shb_application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    
    NSLog(@"Token is [%@]", deviceToken);
    
}

- (void)shb_applicationWillEnterForeground:(UIApplication *)application {
    [[SHBHook sharedInstance] shb_applicationWillEnterForeground:application];
    
    NSLog(@"即将进入前台");
    
}


@end
