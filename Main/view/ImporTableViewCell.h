//
//  ImporTableViewCell.h
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailImageModel.h"
#import "FavourModel.h"

@interface ImporTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel  *addressLab;     //地址标签
@property (nonatomic, strong) UILabel  *titleLab;       //主题标签
@property (nonatomic, strong) UIButton *favourBtn;      //点赞按钮
@property (nonatomic, strong) UILabel  *favourCountLab; //点赞个数
@property (nonatomic, strong) UIButton *focusBtn;       //关注按扭
@property (nonatomic, strong) UIButton *shareBtn;       //分享按钮
@property (nonatomic, strong) UIScrollView *scroll;     //滚动视图
@property (nonatomic, strong) DetailImageModel *detailModel;
@property (nonatomic, strong) FavourModel      *favourModel;

@end
