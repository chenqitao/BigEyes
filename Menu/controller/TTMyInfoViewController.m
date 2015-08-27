//
//  TTMyInfoViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTMyInfoViewController.h"

@interface TTMyInfoViewController ()
{
    UIImageView    *IconImage;    //用户头像
    UILabel        *nameLab;      //昵称
    UILabel        *titleLab;     //标题签名

}

@end

@implementation TTMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的信息";
    // Do any additional setup after loading the view.
}

-(void)createUI {
    IconImage = [UIImageView new];
    [self.view addSubview:IconImage];
    [IconImage sd_setImageWithURL:[NSURL URLWithString:_infoModel.userImage]];
    IconImage.layer.cornerRadius = 40;
    [IconImage.layer setMasksToBounds:YES];
    IconImage.userInteractionEnabled = YES;
    IconImage.layer.borderWidth = 2;
    IconImage.layer.borderColor = TTColor(255, 0, 19, 1).CGColor;

    [IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    nameLab  = [UILabel new];
    [self.view addSubview:nameLab];
    nameLab.text = _infoModel.name;
    nameLab.textColor = TTColor(255, 0, 19, 1);
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IconImage.mas_bottom).with.offset(10);
        make.centerX.equalTo(IconImage.mas_centerX);
    }];
    
    titleLab  = [UILabel new];
    [self.view addSubview:titleLab];
    titleLab.text = @"一切从心开始";
    titleLab.font = [UIFont fontWithName:@"Comic Sans MS" size:25];
    titleLab.font = [UIFont boldSystemFontOfSize:20];
    titleLab.textColor = TTColor(255, 0, 19, 1);
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).with.offset(100);
        make.centerX.equalTo(IconImage.mas_centerX);
    }];
}



@end
