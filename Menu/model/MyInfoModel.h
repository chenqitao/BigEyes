//
//  MyInfoModel.h
//  BigEyes
//
//  Created by mac chen on 15/8/26.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfoModel : NSObject<NSCopying,NSCoding>
/** 昵称 */
@property (nonatomic, copy)  NSString *name;
/** 用户头像 */
@property (nonatomic, copy)  NSString *userImage;

@end
