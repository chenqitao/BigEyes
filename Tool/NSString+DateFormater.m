//
//  NSString+DateFormater.m
//  BigEyes
//
//  Created by mac chen on 15/8/25.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "NSString+DateFormater.h"

@implementation NSString (DateFormater)

#pragma mark  格式化时间戳
+ (NSString *)dateFormaterWithTime:(NSString *)time {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]] ;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formater stringFromDate:date];
    
    
}
@end
