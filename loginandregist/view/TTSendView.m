//
//  TTSendView.m
//  BigEyes
//
//  Created by mac chen on 15/8/31.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTSendView.h"

@implementation TTSendView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self creatUI];
        
    }
    return self;
}

- (void)creatUI {
    _bgView = [UIView new];
    [self addSubview:_bgView];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.alpha = 0.5;
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _numLab = [UILabel new];
    [_bgView addSubview:_numLab];
    _numLab.text = @"+86";
    _numLab.textColor = [UIColor whiteColor];
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.mas_left).with.offset(5);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.width.equalTo(@50);
    }];
    
    _selectBtn = [UIButton new];
    [_bgView addSubview:_selectBtn];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numLab.mas_right).with.offset(10);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.width.equalTo(@20);
    }];
    
    _numfld = [UITextField new];
    [_bgView addSubview:_numfld];
    _numfld.tag = SendtextfiledTag;
    _numfld.keyboardAppearance = UIKeyboardAppearanceAlert;
    _numfld.keyboardType = UIKeyboardTypeNumberPad;
    _numfld.textColor = [UIColor whiteColor];
    _numfld.placeholder = @"输入手机号码";
    [_numfld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).with.offset(10);
        make.centerY.equalTo(_bgView.mas_centerY);
        make.right.equalTo(_bgView.mas_right).with.offset(-70);
        
    }];
    
    _sendBtn = [UIButton new];
    [self addSubview:_sendBtn];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sendBtn.backgroundColor = TTColor(28, 141, 245, 1);
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_numfld.mas_right).with.offset(0);
        make.right.equalTo(_bgView.mas_right).with.offset(0);
        make.bottom.equalTo(_bgView.mas_bottom).with.offset(0);
        make.height.equalTo(_bgView.mas_height);
    }];
   

}
@end
