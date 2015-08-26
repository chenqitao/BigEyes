//
//  TTFocusTableViewCell.h
//  BigEyes
//
//  Created by mac chen on 15/8/26.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusModel.h"

@interface TTFocusTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel     *nameLab;     //用户昵称
@property (nonatomic, strong) UIImageView *Icon;        //用户头像
@property (nonatomic, strong) UIImageView *focusImage;  //关注图片
@property (nonatomic, strong) UILabel     *timeLab;     //发帖时间
@property (nonatomic, strong) FocusModel  *focusModel;  //关注数据
@property (nonatomic, strong) UILabel     *subjectLab;  //主题标签


@end
