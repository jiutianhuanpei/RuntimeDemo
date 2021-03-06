//
//  SHBModel.h
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHBTemp : NSObject

@property (nonatomic, copy) NSString *name;

@end

@interface SHBModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL isMan;
@property (nonatomic, strong) NSArray *cups;

@property (nonatomic, strong) SHBTemp *temp;

@end
