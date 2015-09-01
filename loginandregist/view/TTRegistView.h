//
//  TTRegistView.h
//  BigEyes
//
//  Created by mac chen on 15/9/1.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTRegistView : UIView
@property (nonatomic, strong) UIView      *bgView;    //底部背景
@property (nonatomic, strong) UILabel     *numLab;    //区号Lab
@property (nonatomic, strong) UIButton    *selectBtn; //选择区号按钮
@property (nonatomic, strong) UITextField *numfld;    //电话号码输入框
@property (nonatomic, strong) UIButton    *resendBtn;   //发送按钮

@end
