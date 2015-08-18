//
//  TTMenuTableViewCell.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTMenuTableViewCell.h"

@implementation TTMenuTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.accessoryType   = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)creatUI {
    _Icon = [UIImageView new];
    [self.contentView addSubview:_Icon];
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(35);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    _titleLab = [UILabel new];
    [self.contentView addSubview:_titleLab];
    _titleLab.textColor = [UIColor whiteColor];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_Icon.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
