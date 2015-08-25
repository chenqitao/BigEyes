//
//  ImageTableViewCell.m
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "ImageTableViewCell.h"



@implementation ImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellEditingStyleNone;
    if (self) {
      
        [self createUI];
       
    
    }
    return self;

}


- (void)createUI{
    _backgroundImage = [UIImageView new];
    [self.contentView addSubview:_backgroundImage];
    [_backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    _userImage = [UIImageView new];
    _userImage.layer.cornerRadius = 25;
    [_userImage.layer setMasksToBounds:YES];
    [self.contentView addSubview:_userImage];
    [_userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    
    _blurView = [UIView new];
    [_backgroundImage addSubview:_blurView];
    _blurView.alpha = 0.6;
    _blurView.backgroundColor = [UIColor blackColor];
    [_blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backgroundImage.mas_right).with.offset(0);
        make.left.equalTo(_backgroundImage.mas_left).with.offset(0);
        make.bottom.equalTo(_backgroundImage.mas_bottom).with.offset(0);
        make.height.equalTo(@90);
    }];

    _titleLab = [UILabel new];
    [_blurView addSubview:_titleLab];
    _titleLab.font = [UIFont fontWithName:nil size:17];
    _titleLab.textColor = [UIColor whiteColor];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blurView.mas_left).with.offset(8);
        make.top.equalTo(_blurView.mas_top).with.offset(8);
        make.width.equalTo(@(TTScreenWidth-70));
        make.height.equalTo(@40);
    }];
    
    _commentBtn = [UIButton new];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn setBackgroundImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-50);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
   
    _focusBtn = [UIButton new];
    [self.contentView addSubview:_focusBtn];
    [_focusBtn setBackgroundImage:[UIImage imageNamed:@"heartBtn"] forState:UIControlStateNormal];
    [_focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_commentBtn.mas_centerX);
        make.top.equalTo(_commentBtn.mas_bottom).with.offset(20);
        make.bottom.equalTo(_blurView.mas_bottom).with.offset(-10);
        make.width.equalTo(@30);
       
    }];
    
    _time = [UILabel new];
    [_blurView addSubview:_time];
    _time.font = [UIFont fontWithName:nil size:13];
    _time.textColor = [UIColor whiteColor];
    [_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_focusBtn.mas_centerY);
        make.left.equalTo(_blurView.mas_left).with.offset(8);
        make.right.equalTo(_focusBtn.mas_left).with.offset(-22);
      
    }];
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
