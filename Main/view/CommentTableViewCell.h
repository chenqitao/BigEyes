//
//  CommentTableViewCell.h
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailImageModel.h"

@interface CommentTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *Icon;       //头像
@property (nonatomic, strong) UILabel     *nameLab;    //个人名称
@property (nonatomic, strong) UILabel     *timeLab;    //时间
@property (nonatomic, strong) UILabel     *commentLab; //评论内容
@property (nonatomic, strong) DetailImageModel *detailModel;

@end
