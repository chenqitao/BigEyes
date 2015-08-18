//
//  ImageTableViewCell.h
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"


@interface ImageTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userImage;   //用户头像
@property (nonatomic, strong) UIImageView *backgroundImage;  //背景图片
@property (nonatomic, strong) UIView      *blurView;    //透明图片
@property (nonatomic, strong) UILabel     *titleLab;    //标题
@property (nonatomic, strong) UILabel     *time;        //时间
@property (nonatomic, strong) UIButton    *commentBtn;  //评论
@property (nonatomic, strong) UIButton    *focusBtn;    //关注
@property (nonatomic, strong)   ImageModel  *imagemodel;  //数据

@end
