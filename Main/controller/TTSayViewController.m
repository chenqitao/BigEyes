//
//  TTSayViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/27.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTSayViewController.h"

@interface TTSayViewController ()
{
    UITextView  *textView;      //输入框
    UILabel     *placeholder;   //提示语
    UIView      *whiteView;     //底部

}
@end

@implementation TTSayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStyleDone target:self action:@selector(upload)];
    // Do any additional setup after loading the view.
}

- (void)createUI {
    
    textView = [UITextView new];
    [self.view addSubview:textView];
 
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(80);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@100);
    }];
    
    whiteView = [UIView new];
    [self.view addSubview:whiteView];
    whiteView.layer.borderWidth = 1;
    whiteView.layer.borderColor = TTColor(212, 210, 214, 1).CGColor;
    whiteView.clipsToBounds = YES;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(79);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@102);
    }];
    [self.view bringSubviewToFront:textView];
    
    placeholder = [UILabel new];
    [self.view addSubview:placeholder];
    placeholder.textColor = [UIColor grayColor];
    placeholder.text = @"来都来了，说点什么吧·····";
    [placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
    


}

- (void)upload {
    UpYun *upyun = [[UpYun alloc]init];
   

}



@end
