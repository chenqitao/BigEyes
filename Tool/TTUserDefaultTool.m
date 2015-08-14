//
//  TTUserDefaultTool.m
//  BigEyes
//
//  Created by mac chen on 15/7/6.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTUserDefaultTool.h"

@implementation TTUserDefaultTool
+ (void)setObject:(id)objct forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:objct forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key
{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    return obj;
}

+ (void)removeObjectForKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
  
}

+ (BOOL)isEmptyForKey:(NSString *)key
{
    BOOL isEmpty = YES;
    id a = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (a && [a length] && ![[NSString stringWithFormat:@"%@",[TTUserDefaultTool objectForKey:key]] isEqual:@"(null)"]) {
        isEmpty = NO;
    }
    return isEmpty;
}
@end
