//
//  MBProgressHUD+Simple.h
//  BJEducation
//
//  Created by archer on 10/29/14.
//  Copyright (c) 2014 com.bjhl. All rights reserved.
//

#import "MBProgressHUD.h"


@interface MBProgressHUD (Simple)

/**
 *  显示错误信息
 *
 *  @param msg         消息内容
 */
- (void)showErrorThenHide:(NSString *)msg;
- (void)showErrorThenHide:(NSString *)msg onHide:(void (^)())onHide;

/**
 *  在UIWindow上显示error hud
 *
 *  @param msg 消息内容
 */
+ (void)showWindowErrorThenHide:(NSString *)msg;


/**
 *  显示成功消息
 *
 *  @param msg  消息内容
 */
- (void)showSuccessThenHide:(NSString *)msg;
- (void)showSuccessThenHide:(NSString *)msg onHide:(void (^)())onHide;

/**
 *  在UIWindow上显示success hud
 *
 *  @param msg 消息内容
 */
+ (void)showWindowSuccessThenHide:(NSString *)msg;

/**
 *  显示toast
 *
 *  @param msg  消息内容
 *  @param view 所在的superview
 */
+ (void)showMessageThenHide:(NSString *)msg toView:(UIView*)view;
+ (void)showMessageThenHide:(NSString *)msg toView:(UIView *)view onHide:(void (^)())onHide;

/**
 *  在UIWindow上显示消息
 *
 *  @param msg 消息内容
 */
+ (void)showWindowMessageThenHide:(NSString *)msg;


//如上三个都会显示后自动小时，下面这个不会自动消失：

/**
 *  显示加载中，以及文本消息
 *
 *  @param msg  消息内容，如果为nil，则只显示loading图
 *  @param view 所在的superview
 *
 *  @return 返回当前hud，方便之后hide
 */
+ (MBProgressHUD*) showLoading:(NSString *)msg toView:(UIView *)view;


/**
 *  在UIWindow上显示loading
 *
 *  @param msg 显示的消息
 */
+ (void)showWindowLoading:(NSString *)msg;


/**
 *  关闭UIWindow上的hud
 */
+ (void)closeOnWindow;
@end
