//
//  ImageModel.h
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

/** 作者 */
@property (nonatomic, copy)  NSString *author;
/** 作者id */
@property (nonatomic, copy)  NSString *authorid;
/** 是否开放 */
@property (nonatomic, assign)  BOOL  closed;
/** 发表时间 */
@property (nonatomic, assign)  NSNumber *dateline;
/** 分类id */
@property (nonatomic, assign)  NSInteger fid;
/** 回复数 */
@property (nonatomic, assign)  NSInteger replies;
/** 图片地址 */
@property (nonatomic, copy)  NSString *snapurl;
/** 主题 */
@property (nonatomic, copy)  NSString *subject;
/** 帖子id */
@property (nonatomic, copy)  NSString *tid;
/** 用户头像 */
@property (nonatomic, copy)  NSString *userImage;
/** 不知*/
@property (nonatomic, assign)  NSInteger views;



@end
