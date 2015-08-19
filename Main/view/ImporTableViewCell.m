//
//  ImporTableViewCell.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "ImporTableViewCell.h"

@implementation ImporTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    
    return self;

}

- (void)creatUI {
    
    _scroll = [UIScrollView new];
    [self.contentView addSubview:_scroll];
    _scroll.scrollEnabled = YES;
    _scroll.pagingEnabled = YES;
    _scroll.showsHorizontalScrollIndicator = NO;   //控制是否显示水平方向的滚动条
    _scroll.showsVerticalScrollIndicator = NO;     //控制是否显示垂直方向的滚动条
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.equalTo(@60);
    }];
    
    _favourBtn = [UIButton new];
    [self.contentView addSubview:_favourBtn];
    [_favourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_scroll.mas_top).with.offset(-10);
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
        make.width.equalTo(@32);
        make.height.equalTo(@27);
    }];

    _favourCountLab = [UILabel new];
    [self.contentView addSubview:_favourCountLab];
    _favourCountLab.font = [UIFont fontWithName:nil size:17];
    _favourCountLab.textColor = TTColor(255, 0, 19, 1);
    [_favourCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_favourBtn.mas_right).with.offset(8);
        make.centerY.equalTo(_favourBtn.mas_centerY);
        make.width.equalTo(@20);
        make.height.equalTo(@21);
    }];

    _focusBtn = [UIButton new];
    [self.contentView addSubview:_focusBtn];
    [_focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_favourCountLab.mas_centerY);
        make.bottom.equalTo(_scroll.mas_top).with.offset(-10);
        make.width.equalTo(@32);
        make.height.equalTo(@27);
    }];

    _shareBtn = [UIButton new];
    [self.contentView addSubview:_shareBtn];
    [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_focusBtn.mas_centerY);
        make.left.equalTo(_focusBtn.mas_right).with.offset(27);
        make.bottom.equalTo(_scroll.mas_top).with.offset(-10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-6);
        make.width.equalTo(@32);
        make.height.equalTo(@27);
    }];

    _addressLab = [UILabel new];
    [self.contentView addSubview:_addressLab];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
        make.right.equalTo(self.contentView.mas_right).with.offset(-8);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.height.equalTo(@20);
    }];

    _titleLab = [UILabel new];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
        make.right.equalTo(self.contentView.mas_right).with.offset(-8);
        make.bottom.equalTo(_favourBtn.mas_top).with.offset(-10);
        make.top.equalTo(_addressLab.mas_bottom).with.offset(10);
        
    }];
    
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
