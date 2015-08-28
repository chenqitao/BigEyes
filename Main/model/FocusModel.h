//
//  FocusModel.h
//  BigEyes
//
//  Created by mac chen on 15/8/19.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FocusModel : NSObject<NSCopying,NSCoding>
/** 附件id */
@property (nonatomic, copy)  NSString *attachment;
/** 作者id */
@property (nonatomic, copy)  NSString *authorid;
/** 用户头像 */
@property (nonatomic, copy)  NSString *avatar_url;
/** credits */
@property (nonatomic, copy)  NSString *credits;
/** 时间 */
@property (nonatomic, copy)  NSString *dateline;
/** 关注id */
@property (nonatomic, copy)  NSString *focusid;
/** 主题图片 */
@property (nonatomic, copy)  NSString *snapurl;
/** status */
@property (nonatomic, copy)  NSString *status;
/** 主题图片 */
@property (nonatomic, copy)  NSString *subject;
/** 帖子id */
@property (nonatomic, copy)  NSString *tid;
/** 本地用户id */
@property (nonatomic, copy)  NSString *uid;
/** 用户昵称 */
@property (nonatomic, copy)  NSString *username;

@end
