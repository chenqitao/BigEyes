//
//  TTFocusTableViewCell.m
//  BigEyes
//
//  Created by mac chen on 15/8/26.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTFocusTableViewCell.h"
#define Iconsize  30
#define FocusImagesizewidth  100
#define FocusImagesizeheight 50

@implementation TTFocusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    _Icon = [UIImageView new];
    [self.contentView addSubview:_Icon];
    
    _nameLab = [UILabel new];
    [self.contentView addSubview:_nameLab];
    
    _timeLab = [UILabel new];
    [self.contentView addSubview:_timeLab];
    
    _focusImage = [UIImageView new];
    [self.contentView addSubview:_focusImage];
    
    _subjectLab = [UILabel new];
    [self.contentView addSubview:_subjectLab];

    _Icon.layer.borderWidth  = 1;
    _Icon.layer.borderColor  = TTColor(255, 48, 48, 1).CGColor;
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.width.equalTo(@Iconsize);
        make.height.equalTo(@Iconsize);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_Icon.mas_centerY);
        make.left.equalTo(_Icon.mas_left).with.offset(10);
        make.right.equalTo(_timeLab.mas_left).with.offset(10);
        
    }];
    
   
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_Icon.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        
    }];
    
    [_focusImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).with.offset(30);
        make.left.equalTo(self.contentView.mas_left).with.offset(60);
        make.height.equalTo(@FocusImagesizeheight);
        make.width.equalTo(@FocusImagesizewidth);
    }];
    
    _subjectLab.font = [UIFont fontWithName:nil size:11];
    [_subjectLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).with.offset(30);
        make.left.equalTo(_focusImage.mas_right).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(10);
        
    }];
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
