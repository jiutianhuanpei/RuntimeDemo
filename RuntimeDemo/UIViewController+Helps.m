
//
//  UIViewController+Helps.m
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import "UIViewController+Helps.h"
#import "SHBCommonFunctions.h"


@implementation UIViewController (Helps)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
        Class class = [self class];
        
        SEL didLoad = @selector(viewDidLoad);
        SEL shbDidLoad = @selector(shb_ViewDidLoad);
        
        AssociateWithSelector(class, didLoad, class, shbDidLoad);
    });
}

- (void)shb_ViewDidLoad {
    [self shb_ViewDidLoad];
    
    NSLog(@"%@ didLoad", NSStringFromClass([self class]));
    
}

@end
