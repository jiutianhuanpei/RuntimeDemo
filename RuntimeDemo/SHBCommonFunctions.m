//
//  SHBCommonFunctions.m
//  RuntimeDemo
//
//  Created by shenhongbang on 16/9/13.
//  Copyright © 2016年 中移(杭州)信息技术有限公司. All rights reserved.
//

#import "SHBCommonFunctions.h"
#import <objc/runtime.h>


void AssociateWithSelector(Class class1, SEL selector1, Class class2, SEL selector2) {
    
    Method method1 = class_getInstanceMethod(class1, selector1);
    Method method2 = class_getInstanceMethod(class2, selector2);
    
    BOOL addMethod = class_addMethod(class1, selector1, method_getImplementation(method2), method_getTypeEncoding(method2));
    
    if (addMethod) {
        class_replaceMethod(class2, selector2, method_getImplementation(method1), method_getTypeEncoding(method1));
    } else {
        method_exchangeImplementations(method1, method2);
    }
}



BOOL isFoundationClass(id obj) {

    NSArray *allClass = @[[NSString class],
                          [NSAttributedString class],
                          [NSNumber class],
                          [NSData class],
                          [NSDate class],
                          [NSIndexPath class],
                          ];
    Class class = [obj class];

    
    __block BOOL flag = false;
    [allClass enumerateObjectsUsingBlock:^(Class obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([class isSubclassOfClass:obj]) {
            flag = true;
            *stop = true;
        }
    }];
    
    return flag;
}

NSDictionary *modelToDic(id object) {
    unsigned int outCount;
    objc_property_t *list = class_copyPropertyList([object class], &outCount);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = list[i];
        
        const char *nameChar = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:nameChar];
        
        id value = [object valueForKey:name];
        if (value != nil) {
            
            if (isFoundationClass(value)) {
                
                [dic setValue:value forKey:name];
                
            } else {
                
                if ([value isKindOfClass:[NSDictionary class]]) {
                    
                    if ([NSJSONSerialization isValidJSONObject:value]) {
                        
                        [dic setValue:value forKey:name];
                        continue;
                    }
                    
                    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithCapacity:0];
                    for (NSString *key in (NSDictionary *)value) {
                        id tempValue = [value valueForKey:key];
                        
                        if (tempValue == nil) {
                            tempValue = (id)kCFNull;
                        }
                        [tempDic setValue:tempValue forKey:key];
                    }
                    [dic setValue:tempDic forKey:name];
                } else if ([value isKindOfClass:[NSSet class]]) {
                    NSArray *allData = [(NSSet *)value allObjects];
                    if ([NSJSONSerialization isValidJSONObject:allData]) {
                        [dic setValue:value forKey:name];
                        continue;
                    }
                    
                    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
                    for (id ob in allData) {
                        if ([ob isKindOfClass:[NSString class]] || [ob isKindOfClass:[NSNumber class]]) {
                            [dataArray addObject:ob];
                        } else {
                            if (ob != nil) {
                                [dataArray addObject:ob];
                            }
                        }
                    }
                    [dic setValue:dataArray forKey:name];
                } else  if ([value isKindOfClass:[NSArray class]]) {
                    
                    if ([NSJSONSerialization isValidJSONObject:value]) {
                        [dic setValue:value forKey:name];
                        continue;
                    }
                    
                    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
                    for (id ob in (NSArray *)value) {
                        if ([ob isKindOfClass:[NSString class]] || [ob isKindOfClass:[NSNumber class]]) {
                            [dataArray addObject:ob];
                        } else {
                            NSDictionary *dic = modelToDic(ob);
                            [dataArray addObject:dic];
                        }
                    }
                    [dic setValue:dataArray forKey:name];
                } else {
                    
                    NSDictionary *elseDic = modelToDic(value);
                    
                    [dic setValue:elseDic forKey:name];
                }
            }
        }
    }
    return dic;
}

void SHBLogObject(id object) {
    NSDictionary *dic = modelToDic(object);
    NSLog(@"<%@>:\n%@", object, dic);
}



