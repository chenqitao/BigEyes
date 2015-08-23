//
//  CommentTableViewCell.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

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
    //设置圆角以及边框颜色
    _Icon.layer.cornerRadius = 50/2;
    [_Icon.layer setMasksToBounds:YES];
    _Icon.layer.borderWidth  = 1;
    _Icon.layer.borderColor  = TTColor(255, 48, 48, 1).CGColor;
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@50);
    }];
    
    _nameLab = [UILabel new];
    [self.contentView addSubview:_nameLab];
    _nameLab.font = [UIFont fontWithName:nil size:13];
    _nameLab.textColor = TTColor(255, 0, 19, 1);
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_Icon.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.height.equalTo(@30);
        make.width.equalTo(@150);
    }];
    
    _timeLab = [UILabel new];
    [self.contentView addSubview:_timeLab];
    _timeLab.font = [UIFont fontWithName:nil size:13];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.height.equalTo(@30);
    }];
    
    _commentLab = [UILabel new];
    [self.contentView addSubview:_commentLab];
    _commentLab.font = [UIFont fontWithName:nil size:17];
    _commentLab.lineBreakMode = NSLineBreakByCharWrapping;
    _commentLab.numberOfLines = 0;
    [_commentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(65);
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
    }];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    _commentLab.preferredMaxLayoutWidth = CGRectGetWidth(_commentLab.frame);
   


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
