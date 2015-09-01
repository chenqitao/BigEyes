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
    upyun.successBlocker = ^(id data) {
        NSDictionary *receiveData = data;
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",UPYunurl,receiveData[@"url"]];
        [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTUploadFileURL
                                        parmars:@{@"subject":textView.text,
                                                  @"author":[TTUserDefaultTool objectForKey:TTname],
                                                  @"authorid":[TTUserDefaultTool objectForKey:TTuid],
                                                  @"sid":[TTUserDefaultTool objectForKey:TTSessionid],
                                                  @"message":textView.text,
                                                  @"userimage":imageURL,
                                                  @"typeid":@"0",
                                                  @"status":@"i",
                                                  @"devicelat":@"26.625819",
                                                  @"devicelng":@"106.642006"}
        success:^(id responseObject) {
            [MBProgressHUD showMessageThenHide:@"发表成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSError *error) {
            [MBProgressHUD showMessageThenHide:@"发表成功" toView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    
    };
    
    upyun.failBlocker = ^(NSError * error)
    {
        [MBProgressHUD showMessageThenHide:[error description] toView:self.view];
    };
    
    upyun.progressBlocker = ^(CGFloat percent,long long requestDidSendBytes){
        
    };
    //upyun上传图片
    [upyun uploadFile:_holdImagePath saveKey:[self getSaveKey]];

}

#pragma mark 又拍云生成savekey方法
-(NSString * )getSaveKey {
    /**
     *	@brief	方式1 由开发者生成saveKey
     */
    NSDate *d = [NSDate date];
    return [NSString stringWithFormat:@"/%d/%d/%.0f.jpg",[self getYear:d],[self getMonth:d],[[NSDate date] timeIntervalSince1970]];
    
    /**
     *	@brief	方式2 由服务器生成saveKey
     */
    //    return [NSString stringWithFormat:@"/{year}/{mon}/{filename}{.suffix}"];
    
    /**
     *	@brief	更多方式 参阅 http://wiki.upyun.com/index.php?title=Policy_%E5%86%85%E5%AE%B9%E8%AF%A6%E8%A7%A3
     */
    
}

- (int)getYear:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int year=[comps year];
    return year;
}

- (int)getMonth:(NSDate *) date{
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    int month = [comps month];
    return month;
}




@end
