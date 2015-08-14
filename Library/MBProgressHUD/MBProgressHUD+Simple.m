//
//  MBProgressHUD+Simple.m
//  BJEducation
//
//  Created by archer on 10/29/14.
//  Copyright (c) 2014 com.bjhl. All rights reserved.
//

#import "MBProgressHUD+Simple.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (Simple)

- (void)showErrorThenHide:(NSString *)msg
{
    [self showErrorThenHide:msg onHide:nil];
}

+ (void)showWindowErrorThenHide:(NSString *)msg
{
    UIWindow *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:window];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    }
    [hud showErrorThenHide:msg];
}

- (void)showErrorThenHide:(NSString *)msg onHide:(void (^)())onHide
{
    [self showMessageWithIcon:[UIImage imageNamed:@"ic_fo_wi.png"] message:msg hideDelay:2 onHide:onHide];
}

- (void)showSuccessThenHide:(NSString *)msg
{
    [self showSuccessThenHide:msg onHide:nil];
}

+ (void)showWindowSuccessThenHide:(NSString *)msg
{
    UIView *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:window];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    }
    [hud showSuccessThenHide:msg];
}

- (void)showSuccessThenHide:(NSString *)msg onHide:(void (^)())onHide
{
    [self showMessageWithIcon:[UIImage imageNamed:@"ic_ri_wi.png"] message:msg hideDelay:1 onHide:onHide];
}



- (void)showMessageWithIcon:(UIImage *)iconImg message:(NSString *)msg hideDelay:(float)delay onHide:(void (^)())onHide
{
    if (msg == nil){
        [self hide:true];
        if (onHide){
            onHide();
        }
        return;
    }
    
    MBProgressHUD *hud = self;
    hud.detailsLabelText = nil;
    hud.labelText = nil;
    hud.userInteractionEnabled = false;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    hud.opacity = 0.7;
    
    UIView *customView = [[UIView alloc] init];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:iconImg];
    [customView addSubview:iconView];
    CGRect iconFrame = iconView.frame;
    iconFrame.origin.y = 5;
    iconView.frame = iconFrame;
    //customView.frame = CGRectMake(0, 0, 12, 13.5);
    
    /*
     [iconView autoSetDimension:ALDimensionWidth toSize:17.5];
     [iconView autoSetDimension:ALDimensionHeight toSize:12];
     [iconView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
     */
    
    UILabel *textLbl = [[UILabel alloc] init];
    [textLbl setNumberOfLines:0];
    textLbl.backgroundColor = [UIColor clearColor];
    textLbl.font = [UIFont systemFontOfSize:16];
    textLbl.textColor = [UIColor whiteColor];
    [textLbl setText:msg];
    CGSize textSize;
    if ([msg respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        CGRect frame = [msg boundingRectWithSize:CGSizeMake(220, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[textLbl font]} context:nil];
        textSize = frame.size;
    }
    else
        textSize = [msg sizeWithFont:[textLbl font] forWidth:220 lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat strikeWidth = textSize.width;
    CGFloat height = textSize.height > 13 ? textSize.height : 13;
    textLbl.frame = CGRectMake(18, 1.5, strikeWidth, textSize.height);
    customView.frame = CGRectMake(0, 0, 18 + strikeWidth, height + 2);
    [customView addSubview:textLbl];
    
    iconFrame.origin.y = (customView.frame.size.height-iconFrame.size.height)/2;
    iconView.frame = iconFrame;
    
    /*
     [textLbl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
     [textLbl autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:iconView withOffset:5];
     [textLbl autoAlignAxis:ALAxisHorizontal toSameAxisOfView:iconView];
     */
    
    hud.customView = customView;
    [hud show:true];
    [hud hide:YES afterDelay:delay];
    
    if (onHide){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onHide();
        });
    }
}


+ (void)showMessageThenHide:(NSString*) msg toView:(UIView*)view
{
    [self showMessageThenHide:msg toView:view onHide:nil];
}

+ (void)showMessageThenHide:(NSString *)msg toView:(UIView *)view onHide:(void (^)())onHide
{
    if (view == nil) view = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud){
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    hud.detailsLabelText = msg;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = NO;
    // 2秒之后再消失
    int hideInterval = 2;
    [hud hide:YES afterDelay:hideInterval];
    
    if (onHide){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(hideInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onHide();
        });
    }
}

+ (void)showWindowMessageThenHide:(NSString *)msg
{
    UIView *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [MBProgressHUD showMessageThenHide:msg toView:window];
}


+ (MBProgressHUD*) showLoading:(NSString*)msg toView:(UIView *)view
{
    if (view == nil) view = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.detailsLabelText = msg;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16];
    
    // 再设置模式
    hud.mode = MBProgressHUDModeIndeterminate;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;

    return hud;
}

+ (void) showWindowLoading:(NSString *)msg
{
    UIView *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [MBProgressHUD showLoading:msg toView:window];
}


+ (void)closeOnWindow
{
    UIView *window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [[MBProgressHUD HUDForView:window] hide:true];
}


@end
