//
//  FavourModel.h
//  BigEyes
//
//  Created by mac chen on 15/8/19.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavourModel : NSObject<NSCopying,NSCoding>
/** 点赞id */
@property (nonatomic, copy)    NSString  *favour_id;
/** 主题帖id */
@property (nonatomic, assign)  NSInteger tid;
/** 用户id */
@property (nonatomic, copy)    NSString  *uid;
/** 用户头像 */
@property (nonatomic, copy)    NSString  *userImage;



@end
