//
//  TTVerifyView.m
//  BigEyes
//
//  Created by mac chen on 15/9/1.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTVerifyView.h"

@implementation TTVerifyView

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
    
    _numfld = [UITextField new];
    [self addSubview:_numfld];
    _numfld.placeholder = @"请输入验证码";
    _numfld.tag = VerifytextfiledTag;
    _numfld.keyboardType = UIKeyboardTypeNumberPad;
    _numfld.keyboardAppearance = UIKeyboardAppearanceAlert;
    _numfld.textColor = [UIColor whiteColor];
    _numfld.textAlignment = NSTextAlignmentCenter;
    [_numfld setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_numfld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@140);
    }];
    
    
}

@end
