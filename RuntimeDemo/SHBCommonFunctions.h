//
//  SHBCommonFunctions.h
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Hook 一个方法
 *
 *  @param class1    需要 Hook 的方法所在的类
 *  @param selector1 需要 Hook 的方法
 *  @param class2    关联的方法所在的类
 *  @param selector2 关联的方法
 */
void AssociateWithSelector(Class class1, SEL selector1, Class class2, SEL selector2);

/**
 *  打印对象为json
 *
 *  @param object 要打印的对象
 */
void SHBLogObject(id object);

