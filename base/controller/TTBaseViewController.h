//
//  TTBaseViewController.h
//  sinaForJackchen
//
//  Created by mac chen on 15/7/28.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTBaseViewController : UIViewController
@property(nonatomic,assign) BOOL haveBack;  //是否显示返回键
@property(nonatomic,assign) BOOL showNavi;  //是否显示导航栏
@property(nonatomic,assign) BOOL showMenu;  //是否显示菜单键
@property(nonatomic,assign) BOOL isShowModal; //是否弹出模态视图
@property(nonatomic,strong) UITableView *myTableView;


-(id)initWithTableViewOrNOt:(BOOL)haveTableView;
-(void)returenBtnTapped:(id)sender;
-(void)createUI;  //创建界面UI
-(void)createData;  //请求数据
@end
