//
//  TTRegistViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTRegistViewController.h"
#import "TTRegistView.h"
#import "TTVerifyView.h"


@interface TTRegistViewController ()<UITextFieldDelegate>
{
    UIImageView  *bgImage;     //背景图片
    UIButton     *backBtn;     //返回按钮
    UIButton     *endRegBtn;   //完成注册按钮
    TTVerifyView *verifyView;  //验证码输入view
    BOOL         isUpVerify;   //是否升起验证框
    TTRegistView *registView;  //注册窗口
    NSTimer      *timers;      //定时器
    int          time;         //记录时间
}

@end

@implementation TTRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isUpVerify = YES;
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShow:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}



- (void)createUI {
    
    bgImage = [UIImageView new];
    [self.view addSubview:bgImage];
    bgImage.userInteractionEnabled = YES;
    //利用GPUImage实现图片模糊化
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 20.0;
    UIImage *Image = [UIImage imageNamed:@"LoginBg"];
    bgImage.image = [blurFilter imageByFilteringImage:Image];
    [bgImage bk_whenTapped:^{
        [self.view endEditing:YES];
        [verifyView removeFromSuperview];
    }];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    backBtn = [UIButton new];
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn bk_whenTapped:^{
        [self.view endEditing:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.height.equalTo(@25);
        make.width.equalTo(@25);
    }];
    
    endRegBtn = [UIButton new];
    [self.view addSubview:endRegBtn];
    [endRegBtn setTitle:@"完成" forState:UIControlStateNormal];
    [endRegBtn setTintColor:[UIColor whiteColor]];
    [endRegBtn bk_whenTapped:^{
        
    }];
    [endRegBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-5);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    //注册窗口
    registView = [[TTRegistView alloc]initWithFrame:CGRectMake(0, 300*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640)];
    registView.numfld.delegate = self;
    [registView.resendBtn bk_whenTapped:^{
        [self getVerifyCode];
    }];
    [self.view addSubview:registView];
    
 
    
    
    
}

- (void) keyboardWasShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    //这里做一点小小的调整，解决键盘挡住输入框的问题
    keyboardSize.height = keyboardSize.height == 216?252:keyboardSize.height;
    
    
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    float duration = [info [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        
       
    }];
    isUpVerify = YES;
    
    
}

#pragma mark 判断输入的字符规则
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == VerifytextfiledTag) {
        if (string.length == 4) {
            NSLog(@"44444");
        }
        
    }
    else {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        
        if (toBeString.length >= 11 && range.length != 1&&isUpVerify){
            verifyView = [[TTVerifyView alloc]initWithFrame:CGRectMake(0, registView.frame.origin.y, TTScreenWidth, 100*TTScreenWidth/640)];
            [self.view addSubview:verifyView];
            
            [UIView animateWithDuration:0.25 animations:^{
                verifyView.frame = CGRectMake(0, verifyView.frame.origin.y+100*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640);
            }];
            
            isUpVerify = !isUpVerify;
            
        }
        if (toBeString .length > 11) {
            return NO;
        }
        if (toBeString.length == 11) {
            //关于这里为什么加定时器我也是醉了，因为如果不加的话，它只截取到10位数而我需要到11位
            timers = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleMaxShowTimer:) userInfo:nil repeats:NO];
            
        }
    
    
    }
  
    return YES;
    
}

//触发定时器
- (void)handleMaxShowTimer:(NSTimer *)timer
{
    [self getVerifyCode];
}

#pragma 获取验证码
- (void)getVerifyCode {
    [MBProgressHUD showWindowMessageThenHide:@"正在获取验证码"];
    //获取短信验证码
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:registView.numfld.text zone:@"86" result:^(SMS_SDKError *error) {
        if (!error) {
            [MBProgressHUD showWindowSuccessThenHide:@"验证码发送成功"];
            
        } else {
            [MBProgressHUD showWindowErrorThenHide:@"获取验证码失败"];
        }
    }];

}





@end
