//
//  NSString+md5String.m
//  BigEyes
//
//  Created by mac chen on 15/9/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "NSString+md5String.h"
#import "CommonCrypto/CommonDigest.h"

@implementation NSString (md5String)
#pragma -mark 对账户的密码进行加密
+ (NSString *)md5HexDigest:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}

@end
