//
//  DetailImageModel.h
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailImageModel : NSObject
/** 是否匿名 */
@property (nonatomic, assign) BOOL anonymous;
/** 附件 */
@property (nonatomic, copy)   NSString *attachment;
/** 名称 */
@property (nonatomic, copy)   NSString *author;
/** 用户头像 */
@property (nonatomic, copy)   NSString *avatar_url;
/** avatarstatus */
@property (nonatomic, copy)   NSString *avatarstatus;
/** 时间戳*/
@property (nonatomic, copy)   NSString *dateline;
/** 类别id */
@property (nonatomic, assign) NSInteger fid;
/** 精度 */
@property (nonatomic, copy)   NSString *lat;
/** 纬度 */
@property (nonatomic, copy)   NSString *lng;
/** 内容 */
@property (nonatomic, copy)   NSString *message;
/** 帖子id */
@property (nonatomic, copy)   NSString *pid;
/** 主题内容 */
@property (nonatomic, copy)   NSString *subject;
/** 当前主题帖id */
@property (nonatomic, assign) NSInteger tid;
/** 用户id */
@property (nonatomic, copy)   NSString *uid;
/** 用户名 */
@property (nonatomic, copy)   NSString *username;


@end
