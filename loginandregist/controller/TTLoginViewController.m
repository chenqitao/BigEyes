//
//  TTLoginViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/14.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTLoginViewController.h"
#import "TTRegistViewController.h"
#import "TTSendView.h"
#import "TTVerifyView.h"
#import "CommonCrypto/CommonDigest.h"
#import "ImageListViewController.h"


@interface TTLoginViewController ()<UITextFieldDelegate>
{
    UIImageView  *bgImage;     //背景模糊图片
    UILabel      *titleLab;    //主页标题Lab
    UILabel      *placeholder; //placeholder
    UITextField  *numberfld;   //手机号码输入框
    UIButton     *loginBtn;    //登录按钮
    UIButton     *registBtn;   //注册按钮
    UIView       *regView;     //注册底部
    UIView       *fldView;     //输入框底部
    UITextField  *upfld;       //升起键盘输入框
    TTSendView   *sendView;    //手机号输入view
    TTVerifyView *verifyView;  //验证码输入view
    BOOL         isUpVerify;   //是否升起验证框
    NSTimer      *timers;      //定时器
    int          time;         //记录时间
    
}

@end

@implementation TTLoginViewController

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
    
    titleLab = [UILabel new];
    [bgImage addSubview:titleLab];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"BigEyes";
    titleLab.font = [UIFont fontWithName:@"Marker Felt" size:30];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImage.mas_centerX);
        make.top.equalTo(bgImage.mas_top).with.offset(160*TTScreenWidth/640);
        make.width.equalTo(@200);
        make.height.equalTo(@50);
        
    }];
    
    regView = [UIView new];
    [bgImage addSubview:regView];
    regView.backgroundColor = [UIColor blackColor];
    regView.alpha = 0.5;
    [regView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage.mas_left).with.offset(0);
        make.right.equalTo(bgImage.mas_right).with.offset(0);
        make.bottom.equalTo(bgImage.mas_bottom).with.offset(0);
        make.height.equalTo(@(100*TTScreenWidth/640));
    }];
    
    registBtn = [UIButton new];
    [self.view addSubview:registBtn];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.showsTouchWhenHighlighted = YES;
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];

    [registBtn bk_whenTapped:^{
        TTRegistViewController *registVC = [[TTRegistViewController alloc]init];
        registVC.showNavi = NO;
        registVC.haveBack = NO;
        [self.navigationController pushViewController:registVC animated:YES];
        
    }];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(regView);
    }];
    
    fldView = [UIView new];
    [bgImage addSubview:fldView];
    fldView.backgroundColor = [UIColor blackColor];
    fldView.alpha = 0.3;
    [fldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage.mas_left).with.offset(0);
        make.right.equalTo(bgImage.mas_right).with.offset(-70);
        make.bottom.equalTo(regView.mas_top).with.offset(0);
        make.height.equalTo(@(100*TTScreenWidth/640));
    }];
    
    upfld = [UITextField new];
    [self.view addSubview:upfld];
    upfld.keyboardAppearance = UIKeyboardAppearanceAlert;
    upfld.keyboardType = UIKeyboardTypeNumberPad;
    [upfld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(fldView);
    }];
    
    placeholder = [UILabel new];
    [fldView addSubview:placeholder];
    placeholder.textColor = [UIColor whiteColor];
    placeholder.text = @"使用手机号码登录";
    placeholder.font = [UIFont fontWithName:nil size:12];
    [placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fldView.mas_left).with.offset(10);
        make.centerY.equalTo(fldView.mas_centerY);
    }];
    
   
    
    
    loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    loginBtn.backgroundColor = TTColor(255, 211, 0, 1);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.tintColor = [UIColor yellowColor];
    [loginBtn bk_whenTapped:^{
        [upfld becomeFirstResponder];
    }];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(fldView.mas_right).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(regView.mas_top).with.offset(0);
        make.height.equalTo(fldView.mas_height);
    }];
    
 //   登录键盘升起的view
    sendView = [[TTSendView alloc]initWithFrame:CGRectMake(0, TTScreenHeight, TTScreenWidth, 100*TTScreenWidth/640)];
    sendView.numfld.delegate = self;
    [self.view addSubview:sendView];


}



#pragma mark  键盘升落方法

- (void) keyboardWasShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;
    //这里做一点小小的调整，解决键盘挡住输入框的问题
    keyboardSize.height = keyboardSize.height == 216?252:keyboardSize.height;

    [UIView animateWithDuration:0.25 animations:^{
        //self.view.frame = CGRectMake(0, -keyboardSize.height, TTScreenWidth, TTScreenHeight);
        sendView.frame = CGRectMake(0, TTScreenHeight - keyboardSize.height-14, TTScreenWidth, 100*TTScreenWidth/640);
        sendView.numfld.text = @"";
        [sendView.numfld becomeFirstResponder];
        
        
    }];
    
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    float duration = [info [UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    
    [UIView animateWithDuration:duration animations:^{
        
       // self.view.frame = CGRectMake(0, 0, TTScreenWidth, TTScreenHeight );
         sendView.frame = CGRectMake(0, TTScreenHeight, TTScreenWidth, 100*TTScreenWidth/640);
    }];
    isUpVerify = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];


}

#pragma mark 判断输入的字符规则
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
      NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == VerifytextfiledTag) {
        if (toBeString.length == 4) {
           
            [SMS_SDK commitVerifyCode:toBeString result:^(enum SMS_ResponseState state) {
            if (state == 1) {
                [MBProgressHUD showMessageThenHide:@"验证成功" toView:self.view];
                [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTLoginURL parmars:@{@"useracc":numberfld.text,@"userpw":[self md5HexDigest:TTDefaultPwd]} success:^(id responseObject) {
                    if (responseObject[@"datas"][0][@"uid"]&& ![responseObject[@"datas"][0][@"sessionid"] isEqualToString:@"aperror"]) {
                        [TTUserDefaultTool setObject:numberfld.text forKey:TTname];
                        [TTUserDefaultTool setObject:[self md5HexDigest:TTDefaultPwd] forKey:TTpassword];
                        [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTSessionid];
                        [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"uid"] forKey:TTuid];
                        
                        //跳到主界面
                        ImageListViewController *imageVC = [[ImageListViewController alloc]init];
                        UINavigationController *nav      = [[UINavigationController alloc]initWithRootViewController:imageVC];
                        self.view.window.rootViewController = nav;
                    }
                    
                    
                } fail:^(NSError *error) {
                    
                }];
                }
                else{
                    [MBProgressHUD showMessageThenHide:@"验证失败" toView:self.view];
                }
            }];
            
        }
        if (toBeString.length > 4) {
            return NO;
        }
    }
    else {
        if (toBeString.length >= 11 &&isUpVerify){
            verifyView = [[TTVerifyView alloc]initWithFrame:CGRectMake(0, sendView.frame.origin.y+100*TTScreenWidth/640,  TTScreenWidth, 100*TTScreenWidth/640)];
            verifyView.numfld.delegate = self;
            [self.view addSubview:verifyView];
            
            [UIView animateWithDuration:0.25 animations:^{
            verifyView.frame = CGRectMake(0, verifyView.frame.origin.y-100*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640);
            sendView.frame   = CGRectMake(0, sendView.frame.origin.y-100*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640);
            }];
            
            isUpVerify = !isUpVerify;
            
        }
        if (toBeString .length >= 12) {
            
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
    [MBProgressHUD showWindowMessageThenHide:@"正在获取验证码"];
    //获取短信验证码
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:sendView.numfld.text zone:@"86" result:^(SMS_SDKError *error) {
        if (!error) {
            [MBProgressHUD showWindowSuccessThenHide:@"验证码发送成功"];
            
        } else {
            [MBProgressHUD showWindowErrorThenHide:@"获取验证码失败"];
        }
    }];
    
}


#pragma -mark 对账户的密码进行加密
- (NSString *)md5HexDigest:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
    
}




@end
