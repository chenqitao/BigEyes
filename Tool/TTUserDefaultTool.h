//
//  TTUserDefaultTool.h
//  BigEyes
//
//  Created by mac chen on 15/7/6.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUserDefaultTool : NSObject
+ (void)setObject:(id)objct forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;
+ (BOOL)isEmptyForKey:(NSString *)key;

@end
