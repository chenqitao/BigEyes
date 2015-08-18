//
//  TTMenuViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/17.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTMenuViewController.h"
#import "TTMenuTableViewCell.h"
#import "TTMyInfoViewController.h"
#import "TTAboutUsViewController.h"
#import "TTFocusViewController.h"
#import "TTSettingsViewController.h"

@interface TTMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView    *IconImage;    //用户头像
    UILabel        *nameLab;      //个性签名
    NSArray        *dataSource;   //title数据
    UITableView    *mytableView;
    

}

@end

@implementation TTMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
}

-(void)createUI {
    IconImage = [UIImageView new];
    [self.view addSubview:IconImage];
    IconImage.image = [UIImage imageNamed:@"placeholder"];
    IconImage.layer.cornerRadius = 40;
    [IconImage.layer setMasksToBounds:YES];
    [IconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(31);
        make.left.equalTo(self.view.mas_left).with.offset(70);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    
    nameLab  = [UILabel new];
    [self.view addSubview:nameLab];
    nameLab.text = @"蜂蜜柚子茶";
    nameLab.textColor = [UIColor whiteColor];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IconImage.mas_bottom).with.offset(10);
        make.centerX.equalTo(IconImage.mas_centerX);
    }];
    
    mytableView = [UITableView new];
    [self.view addSubview:mytableView];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    mytableView.scrollEnabled = NO;
    mytableView.showsHorizontalScrollIndicator = NO;
    mytableView.showsVerticalScrollIndicator = NO;
    mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLab.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(100);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    mytableView.backgroundColor = [UIColor clearColor];
    

}

-(void)createData {
    dataSource = @[@"个人资料",@"关注列表",@"关于我们",@"设置"];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cell";
    TTMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[TTMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [self configureCell:cell withIndexPath:indexPath];
    return cell;

}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    TTMenuTableViewCell *menuTableViewCell = (TTMenuTableViewCell *)cell;
    menuTableViewCell.titleLab.text = dataSource[indexPath.row];
  
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            UINavigationController *nav = (UINavigationController *)self.sideMenuViewController.contentViewController;
            TTMyInfoViewController *infoVC = [[TTMyInfoViewController alloc] init];
            infoVC.showNavi = YES;
            [nav pushViewController:infoVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 1: {
            UINavigationController *nav = (UINavigationController *)self.sideMenuViewController.contentViewController;
            TTFocusViewController *focusVC = [[TTFocusViewController alloc] init];
            focusVC.showNavi = YES;
            [nav pushViewController:focusVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];        }
            break;
        case 2: {
            UINavigationController *nav = (UINavigationController *)self.sideMenuViewController.contentViewController;
            TTAboutUsViewController *aboutVC = [[TTAboutUsViewController alloc] init];
            aboutVC.showNavi = YES;
            [nav pushViewController:aboutVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        case 3: {
            UINavigationController *nav = (UINavigationController *)self.sideMenuViewController.contentViewController;
            TTSettingsViewController *settingsVC = [[TTSettingsViewController alloc] init];
            settingsVC.showNavi = YES;
            [nav pushViewController:settingsVC animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
        default:
            break;
    }

    
    
}

@end
