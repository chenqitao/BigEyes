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
    [_Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
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
        make.left.equalTo(_Icon.mas_right).with.offset(5);
        make.top.equalTo(_nameLab.mas_bottom).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
    }];
    
    
}

-(void)layoutSubviews{
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
