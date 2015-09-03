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
#import "ImageListViewController.h"
#import "TTMenuViewController.h"

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
    RESideMenu   *sideMenuViewController;  //侧滑控制器
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
    
    
    //注册窗口
    registView = [[TTRegistView alloc]initWithFrame:CGRectMake(0, 300*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640)];
    registView.numfld.delegate = self;
    [registView.resendBtn bk_whenTapped:^{
        [self getVerifyCode:registView.numfld.text];
        verifyView = [[TTVerifyView alloc]initWithFrame:CGRectMake(0, registView.frame.origin.y, TTScreenWidth, 100*TTScreenWidth/640)];
        [self.view addSubview:verifyView];
        [UIView animateWithDuration:0.25 animations:^{
            verifyView.frame = CGRectMake(0, verifyView.frame.origin.y+100*TTScreenWidth/640, TTScreenWidth, 100*TTScreenWidth/640);
        }];
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
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == VerifytextfiledTag) {
        if (string.length == 4) {
          [SMS_SDK commitVerifyCode:toBeString result:^(enum SMS_ResponseState state) {
              if (state == 1) {
                  [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTRegistUCenterURL
                    parmars:@{@"email":[NSString stringWithFormat:@"%@@qq.com",registView.numfld.text],
                           @"username":registView.numfld.text,
                           @"password":@"0851888888"}
                  success:^(id responseObject) {
                      
                      if ([responseObject[@"code"]intValue] > 0) {
                          [MBProgressHUD showMessageThenHide:@"注册成功" toView:self.view];
                          [self activationUser];
                          [self login];
                          
                      }
                      else if ([responseObject[@"code"]intValue] == -6) {
                          [MBProgressHUD showMessageThenHide:@"邮箱已被注册" toView:self.view];
                      }
                      else if ([responseObject[@"code"]intValue] == -3) {
                          [self login];
                      }
                      
                  } fail:^(NSError *error) {
                      
                  }];
              }
              else {
               [MBProgressHUD showMessageThenHide:@"验证失败" toView:self.view];
              }
          }];

           
        }
        
    }
    else {
      
  
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
            [self getVerifyCode:toBeString];
        }
        //小于11则移除验证框
         if (toBeString.length < 11) {
            if (verifyView) {
                [verifyView removeFromSuperview];
                isUpVerify = YES;
            }
        }
    
    
    }
  
    return YES;
    
}



#pragma 获取验证码
- (void)getVerifyCode:(NSString *)number{
    [MBProgressHUD showWindowMessageThenHide:@"正在获取验证码"];
    //获取短信验证码
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:number zone:@"86" result:^(SMS_SDKError *error) {
        if (!error) {
            [MBProgressHUD showWindowSuccessThenHide:@"验证码发送成功"];
            
        } else {
            [MBProgressHUD showWindowErrorThenHide:@"获取验证码失败"];
        }
    }];

}

#pragma 将UCenter中的用户激活
- (void)activationUser {
    [[TTHTTPRequest shareHTTPRequest]openAPIGetToMethod:TTactivationURL parmars:@{} success:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];


}

#pragma 登录 
- (void)login {
    [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTLoginURL parmars:@{@"useracc":registView.numfld.text,@"userpw":[NSString md5HexDigest:TTDefaultPwd]} success:^(id responseObject) {
        if (responseObject[@"datas"][0][@"uid"]&& ![responseObject[@"datas"][0][@"sessionid"] isEqualToString:@"aperror"]) {
            [TTUserDefaultTool setObject:registView.numfld.text forKey:TTname];
            [TTUserDefaultTool setObject:[NSString md5HexDigest:TTDefaultPwd] forKey:TTpassword];
            [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"sessionid"] forKey:TTSessionid];
            [TTUserDefaultTool setObject:responseObject[@"datas"][0][@"uid"] forKey:TTuid];
            
            //跳到主界面
            ImageListViewController *imageVC = [[ImageListViewController alloc]init];
            imageVC.showNavi = YES;
            UINavigationController  *navVC   = [[UINavigationController alloc]initWithRootViewController:imageVC];
            TTMenuViewController     *menuVC = [[TTMenuViewController alloc]init];
            sideMenuViewController = [[RESideMenu alloc]initWithContentViewController:navVC leftMenuViewController:menuVC rightMenuViewController:nil];
            sideMenuViewController.panGestureEnabled = YES;
            sideMenuViewController.backgroundImage = [UIImage imageNamed:@"sideground"];
            self.view.window.rootViewController = sideMenuViewController;
        }
        
        
    } fail:^(NSError *error) {
        
    }];


}







@end
