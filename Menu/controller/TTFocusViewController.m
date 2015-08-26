//
//  TTFocusViewController.m
//  BigEyes
//
//  Created by mac chen on 15/8/18.
//  Copyright (c) 2015年 陈齐涛. All rights reserved.
//

#import "TTFocusViewController.h"
#import "FocusModel.h"
#import "TTFocusTableViewCell.h"
#import "TTdetailViewController.h"

@interface TTFocusViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
    UITableView    *mytableView;
}

@end

@implementation TTFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关注";
    dataSource = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [[TTHTTPRequest shareHTTPRequest]openAPIPostToMethod:TTGetFocusListURL parmars:@{@"uid":[TTUserDefaultTool objectForKey:TTuid]} success:^(id responseObject) {
        NSArray *dataArr = responseObject[@"datas"];
        for (NSDictionary *dic in dataArr) {
            FocusModel *focusModel = [FocusModel objectWithKeyValues:dic];
            [dataSource addObject:focusModel];
        }
        [mytableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];

}

- (void)createUI {

    
    mytableView = [UITableView new];
    [self.view addSubview:mytableView];
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [mytableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];


}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSString *identifier = @"cellID";
    
        TTFocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[TTFocusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [self configureCell:cell withIndexPath:indexPath];
        return cell;
    
    

    
}

- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
   
    TTFocusTableViewCell *importableviewcell = (TTFocusTableViewCell *)cell;
    importableviewcell.focusModel            = dataSource[indexPath.row];
    [importableviewcell.Icon sd_setImageWithURL:[NSURL URLWithString:importableviewcell.focusModel.avatar_url]];
    [importableviewcell.focusImage sd_setImageWithURL:[NSURL URLWithString:importableviewcell.focusModel.snapurl]];
    importableviewcell.nameLab.text = importableviewcell.focusModel.username;
    importableviewcell.timeLab.text = [NSString dateFormaterWithTime:importableviewcell.focusModel.dateline];
    importableviewcell.subjectLab.text = importableviewcell.focusModel.subject;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTdetailViewController *detailVC;
    if (!detailVC) {
        detailVC = [[TTdetailViewController alloc]init];
    }
    detailVC.showNavi = NO;
    detailVC.haveBack = NO;
    FocusModel *focusModel = dataSource[indexPath.row];
    detailVC.detailImageURL = focusModel.snapurl;
    detailVC.tid            = focusModel.tid;
    [self.navigationController pushViewController:detailVC animated:YES];

}




@end
