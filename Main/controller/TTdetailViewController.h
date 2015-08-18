//
//  TTdetailViewController.h
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTdetailViewController : TTBaseViewController
/** 详情图片地址 */
@property (nonatomic, copy)   NSString  *detailImageURL;
/** 帖子id */
@property (nonatomic, assign)   NSInteger  tid;

@end
