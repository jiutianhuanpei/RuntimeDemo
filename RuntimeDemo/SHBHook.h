//
//  SHBHook.h
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHBHook : NSObject

+ (instancetype)sharedInstance;

/**
 *  注册关联 app 进入前台
 */
- (void)registEnterForeground;


@end
