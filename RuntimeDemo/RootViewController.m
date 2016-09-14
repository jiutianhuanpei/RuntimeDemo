//
//  RootViewController.m
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "UIViewController+Helps.h"
#import "SHBHook.h"
#import "SHBModel.h"
#import "SHBCommonFunctions.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[SHBHook sharedInstance] registEnterForeground];
    
    SHBModel *tempModel = [[SHBModel alloc] init];
    tempModel.name = @"Jim";
    
    SHBTemp *temp = [[SHBTemp alloc] init];
    temp.name = @"I'm temp";
    
    SHBModel *model = [[SHBModel alloc] init];
    model.name = @"Tim";
    model.age = 30;
    model.isMan = true;
    model.cups = @[@"a", @"b", tempModel];
    model.temp = temp;
    
    SHBLogObject(model);
    
}

@end
