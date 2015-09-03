//
//  NSString+md5String.h
//  BigEyes
//
//  Created by mac chen on 15/9/3.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5String)
+ (NSString *)md5HexDigest:(NSString *)inPutText;
@end
